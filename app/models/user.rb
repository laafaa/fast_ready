class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :users_roles
  has_many :roles, :through => :users_roles
  has_and_belongs_to_many :games
  validates :login, :phone, :email, :password, presence: true
  validates :phone, length: { is: 11, message: " должен содержать 11 цифр"}
  validates :phone, numericality: { only_integer: true, message: " должен содержать только цифры" }
  validates :phone, :login, uniqueness: { is: true, message: " уже используется"}

  
end
