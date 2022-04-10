# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :following_relationships, inverse_of: 'following_user', class_name: 'Follow', foreign_key: 'following_user_id', dependent: :destroy
  has_many :follower_relationships, inverse_of: 'follower_user', class_name: 'Follow', foreign_key: 'follower_user_id', dependent: :destroy
  has_many :followings, through: :follower_relationships, source: :following_user
  has_many :followers, through: :following_relationships, source: :follower_user

  def follow(user_id)
    follower_relationships.create!(following_user_id: user_id)
  end

  def unfollow(user_id)
    follower_relationships.find_by!(following_user_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end
