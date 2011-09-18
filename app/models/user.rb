class User < ActiveRecord::Base
  devise :rememberable, :trackable, :token_authenticatable, :rememberable, :registerable,
         :database_authenticatable, :lockable, :recoverable, :validatable, :confirmable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :commit_mail

  validates :role, :inclusion => {:in => ['logo', 'yavdr']}, :allow_nil => true, :allow_blank => true

  scope :commit_mails, where(:commit_mail => true)

  def role_yavdr?
    role == 'yavdr'
  end

  def role_logo?
    role == 'logo'
  end

end
