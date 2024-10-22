class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :comment, :total_star, :extent_star, :clean_star, :amenity_star, :safety_star, :cost_star, presence: true
end

