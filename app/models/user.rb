class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  attachment :profile_image, destroy: false
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
  #has_many :relationships, foreign_key: "follower_id",
  #dependent: :destroy
  #has_many :follows, through: :relationships, source: :follower
  #has_many :followings, through: :relationships, source: :follow
  #has_many :passive_relationships, class_name:  "Relationship",
               #                    foreign_key: "followed_id",
               #                    dependent:   :destroy
  #has_many :followers, through: :passive_relationships, source: :followed

  validates :name, presence: true, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def posts
  return Book.where(user_id: self.id)
  end

# ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  
  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  
  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
end
