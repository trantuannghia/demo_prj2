class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :name, presence: true

  scope :search_tag, ->search{where "name = ? limit ?", "%#{search}%", 1}
end
