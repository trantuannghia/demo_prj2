class Comment < ApplicationRecord
  belongs_to :post

  validates :content, presence: true,
    length: {maximum: Settings.model.comment.size_content}
  validates :user, presence: true
  validates :post, presence: true
end
