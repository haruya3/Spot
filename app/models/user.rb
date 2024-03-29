require 'uri'
require 'net/http'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :line]
  
  has_many :posts

  has_many :likes
  has_many :post_likes, through: :likes, source: :post

  mount_uploader :user_image, ImageUploader

  validates :username, {uniqueness: true, presence: true, length: {maximum: 15}}

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    if user == nil
      user = User.new(
      uid:      auth.uid,
      provider: auth.provider,
      email:    auth.info.email || User.dummy_email(auth),
      user_image: auth.image,
      username: auth.info.name,
      password: Devise.friendly_token[0, 20]#開発者にも分からないようにランダムなパスワードが作られる。
      )
    elsif user.provider == nil #userアカウント持っていて途中からsns認証使う場合
      user = User.find_by(:email)
      user.update!(
        uid: auth.uid,
        provider: auth.provider
      )
    end
    user.skip_confirmation!
    user.save
    user
  end

  def self.dummy_email(auth)
    return "#{auth.uid}-#{auth.provider}@example.com"
  end

end
