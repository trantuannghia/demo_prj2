class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable,
    :recoverable, :rememberable, :trackable, :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
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

  scope :create_on_week, ->{where "created_at > ?", 1.weeks.ago}

  def feed
    Post.post_following(following_ids,id).order_by_desc
  end

  def is_user? user
    self == user
  end

  def is_admin?
    self.is_admin == 1
  end

  def follow other_user
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
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

    def self.to_xls options = {}
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end

  end

end



end
