class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
    acts_as_token_authenticatable

  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    role == 'admin'
  end

  def worker?
    role == 'worker'
  end

  def manager?
    role == 'manager'
  end

end
