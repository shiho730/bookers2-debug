class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  attachment :profile_image, destroy: false
  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def posts
  return Book.where(user_id: self.id)
  end

end
