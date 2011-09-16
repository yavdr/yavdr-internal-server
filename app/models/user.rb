class User < ActiveRecord::Base
  devise :rememberable, :trackable, :token_authenticatable, :rememberable, :registerable,
         :database_authenticatable, :lockable, :recoverable, :validatable, :confirmable
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
