class Post < ApplicationRecord
  validates :title, :address, :hp, :introduction, presence: true
  # レビュー機能追加したらvalidatesも増やす

  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_tag_relations, dependent: :destroy
  has_many :tags, through: :post_tag_relations
  has_many :favorites, dependent: :destroy

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
    unless user.nil?
      favorites.exists?(user_id: user.id)
    end
  end
  # userがいいねしているか

  def average_total_star
    (comments.average(:total_star) * 2).round / 2.0
  end

end