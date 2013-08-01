class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :name, :email, :password, :password_confirmation
  has_many :posts

  def picture size=50, default="_blank"
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "//gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{default}"
  end
end
