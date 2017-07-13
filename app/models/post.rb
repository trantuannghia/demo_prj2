class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy

  validates :user, presence: true
  validates :title, length: {maximum: Settings.model.post.size_title}
  validates :content, length: {maximum: Settings.model.post.size_content}
end
