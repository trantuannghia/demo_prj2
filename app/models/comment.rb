class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :comment_child, class_name: Comment.name, foreign_key: "comment_parent_id",dependent: :destroy
  belongs_to :comment_parent, class_name: Comment.name, optional: true

  validates :content, presence: true,
    length: {maximum: Settings.model.comment.size_content}
  validates :user, presence: true
  validates :post, presence: true

  scope :check_child, ->{where comment_parent_id: nil}
end
