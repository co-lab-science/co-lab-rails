class Lab < ApplicationRecord
  attr_accessor :user_has_upvoted
  attr_accessor :user_has_downvoted
  attr_accessor :user_has_liked
  attr_accessor :user_has_disliked
  belongs_to :user
  has_many :comments
  has_many :hypotheses
  has_many :questions
  has_many :tags
  has_many :downvotes
  has_many :upvotes
  has_many :likes
  has_many :dislikes
  has_many :lab_files
end

