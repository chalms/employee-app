class User < ActiveRecord::Base
  include JsonSerializingModel
  
  has_many :reports
  has_many :chats

  after_initialize :_set_defaults
  validates_presence_of :password, :length => {:minimum  => 6},  on: :create!
  validate :email, :format => {:with => /\A[^@]+@[^@]+\.[^@]+\Z/}
  before_create :generate_auth_token
  validates_uniqueness_of :auth_token, :on => :create!
  has_secure_password validations: false


  def token 
    unless self.auth_token.present?  
      self.auth_token = SecureRandom.urlsafe_base64(180)
      puts "inside user [before save]-> #{self.auth_token}"
    end 
    self.save!
    puts "inside user [after save] -> #{self.auth_token}"
    return self.auth_token
  end 

  def generate_auth_token
    self.auth_token = SecureRandom.urlsafe_base64(180)
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
