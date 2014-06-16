class User < ActiveRecord::Base
  include JsonSerializingModel
  
  has_many :reports
  has_many :chats
  validates_presence_of :password, on: :create
  after_initialize :_set_defaults

  def role(r)
    if (r.blank?)
      @role = 'user'
    end 
  end 

  def is_admin? 
    return (@role == 'admin') 
  end 

  def is_manager? 
    return (@role == 'manager')
  end 

  def password=(password)
    write_attribute(:password, BCrypt::Password.create(password))
  end

  private

  def _set_defaults
    self.api_secret ||= MicroToken.generate(128)
  end
end
