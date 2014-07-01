class User < ActiveRecord::Base
  include JsonSerializingModel
  
  has_many :user_reports
  has_many :user_chats
  attr_accessible :email, :id, :name, :company_name

  after_initialize :_set_defaults
  validates_presence_of :password, :length => {:minimum  => 6},  on: :create!
  validate :email, :format => {:with => /\A[^@]+@[^@]+\.[^@]+\Z/}

  def clients 
    return nil
  end 

  def chats 
    return self.user_chats.map{ |ur| ur.chat }
  end 

  def reports 
    return self.user_reports.map{ |ur| ur.report }
  end 

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
