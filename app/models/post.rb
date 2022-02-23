class Post < ApplicationRecord
  validates :text, presence: true, unless: :was_attached?
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def was_attached?
    self.image.attached?
  end

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end