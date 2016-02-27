class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 
  has_many :user_transactions
  has_and_belongs_to_many :games
  
  validates :login, :phone, :email, :password, :presence => {message: "Не может быть пустым"}
  
  validates :phone, length: { is: 11, 
    message: " должен содержать 11 цифр"}
  validates :phone, numericality: { only_integer: true, 
    message: " должен содержать только цифры" }
  validates :phone, :login, :email, uniqueness: { is: true, 
    message: "Уже используется"}

  belongs_to :role

  def admin?
    role_id == 1
  end
end
