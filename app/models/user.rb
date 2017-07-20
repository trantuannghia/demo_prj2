class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable,
    :recoverable, :rememberable, :trackable, :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :posts, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.model.user.maximum_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.model.user.maximum_email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.model.user.minimum_password}, allow_nil: true
  validates :phone, length: {maximum: Settings.model.user.minimum_phone}

  def feed
    Post.post_following(following_ids,id).order_by_desc
  end

  def is_user? user
    self == user
  end
  class << self

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
          session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end

    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
      end
    end
  end
end
