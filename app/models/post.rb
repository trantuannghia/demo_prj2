class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :user, presence: true
  validates :title, length: {maximum: Settings.model.post.size_title}
  validates :content, presence:true, length: {maximum: Settings.model.post.size_content}
  validate  :picture_size

  mount_uploader :picture, PictureUploader

  scope :order_by_desc, ->{order created_at: :desc}
  def show_tag
    @tags = self.tags
  end
  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
