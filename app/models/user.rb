class User < ApplicationRecord
  # Articles relations
  has_many :article, dependent: :destroy

  # Followers
  has_many :follower_follows, foreign_key: :followee_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :follower_follows, source: :follower, dependent: :destroy

  # Followee
  has_many :followee_follows, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :followees, through: :followee_follows, source: :followee, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
