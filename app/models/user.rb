class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :users_roles
  has_many :roles, :through => :users_roles
  has_and_belongs_to_many :games
<<<<<<< HEAD
        validates :login, :phone, :email, :password, presence: true
        validates :phone, length: { is: 11, message: " должен содержать 11 цифр"}
        validates :phone, numericality: { only_integer: true, message: " должен содержать только цифры" }
        validates :phone, :login, uniqueness: { is: true, message: " уже используется"}
=======
  validates :login, :phone_number, :email, :password, presence: true
  validates :phone_number, length: { is: 11, message: " должен содержать 11 цифр"}
  validates :phone_number, numericality: { only_integer: true, message: " должен содержать только цифры" }
  validates :phone_number, :login, uniqueness: { is: true, message: " уже используется"}
>>>>>>> 213d59ea853ec768c2436d36947d02a600c4d576
end
