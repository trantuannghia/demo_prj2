class PostTag < ApplicationRecord
  belongs_to :tag
  belongs_to :post

  validates :post, presence: true
  validates :tag, presence: true
end
