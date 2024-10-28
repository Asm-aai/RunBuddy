class Post < ApplicationRecord
  validates :images, :title, :address, :hp, :introduction, presence: true
  validates :address, :hp, uniqueness: true
  validate :image_length

  has_many_attached :images
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_tag_relations, dependent: :destroy
  has_many :tags, through: :post_tag_relations
  has_many :favorites, dependent: :destroy

  # def get_image
  #   unless image.attached?
  #     file_path = Rails.root.join('app/assets/images/no_image.jpg')
  #     image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  #   end
  #   image
  # end

  def favorited_by?(user)
    unless user.nil?
      favorites.exists?(user_id: user.id)
    end
  end
  # userがいいねしているか

  def average_total_star
    average = comments.average(:total_star)
    if average.present?
      (average * 2).round / 2.0
    else
      0
    end
  end

  private
  def image_length
    if images.count > 5
      # images.length > 5 qiitaでは「length」を使用
      errors.add(:images, "は5枚以内にしてください。")
    end
  end

end