class Tag < ApplicationRecord
  has_many :post_tag_relations, dependent: :destroy
  has_many :posts, through: :post_tag_relations

  validates :name, presence: true, unless: :editing_same_name?

  private
  def editing_same_name?
    persisted? && name == Tag.find(id).name
  end

end
