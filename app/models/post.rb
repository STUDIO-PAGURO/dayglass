class Post < ApplicationRecord
  validates :text, presence: true, unless: :was_attached?
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  def self.search(search)
    if search != ""
      Post.where("text LIKE(?)", "%#{search}%")
    else
      Post.all
    end
  end

  def was_attached?
    self.image.attached?
  end
end