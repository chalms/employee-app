class Worker < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #lockable, :timeoutable and :omniauthable

  # Note: you can include any module you want. If available,
  # token authentication will be performed before any other
  # Devise authentication method.
  #
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable, :token_authenticatable, :validatable

  def admin?
    role == 'admin'
  end

end
