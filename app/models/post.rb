class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy

  validates :user, presence: true
  validates :title, length: {maximum: Settings.model.post.size_title}
  validates :content, length: {maximum: Settings.model.post.size_content}
  validate  :picture_size

  default_scope -> {order created_at: :desc}

  mount_uploader :picture, PictureUploader

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
