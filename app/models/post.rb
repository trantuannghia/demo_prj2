class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy

  validates :user, presence: true
  validates :title, length: {maximum: Settings.model.post.size_title}
  validates :content, presence:true, length: {maximum: Settings.model.post.size_content}
  validate  :picture_size

  mount_uploader :picture, PictureUploader

  scope :order_by_desc, ->{order created_at: :desc}
  scope :post_following, lambda{|following_ids, id|
    where "user_id IN (?) OR user_id = ?", following_ids, id
  }

  private

  def picture_size
    if picture.size > Settings.size_picture.megabytes
      errors.add :picture, t(".less_than_5MB")
    end
  end
end
