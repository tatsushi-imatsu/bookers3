class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  attachment :profile_image, destroy: false

  validates :name, presence: true,
  length: { in: 2..20 }, uniqueness: true
  validates :introduction,length: { maximum: 50}

  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def following?(follower)
    self.followings.include?(follower)
  end

  def follow(follower)
    unless self == follower
      self.relationships.find_or_create_by(followed_id: follower.id)
    end
  end

  def unfollow(follower)
    relationship = self.relationships.find_by(followed_id: follower.id)
    relationship.destroy if relationship
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
    
  end

end