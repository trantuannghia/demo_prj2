class PostTag < ApplicationRecord
  belongs_to :tag
  belongs_to :post

  validates :post, presence: true
  validates :tag, presence: true

   scope :search_by_post_id, lambda{|post_id|
    where "post_id = ?", post_id
  }
end
