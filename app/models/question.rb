class Question < ApplicationRecord
  attr_accessor :user_has_upvoted
  attr_accessor :user_has_downvoted
  attr_accessor :user_has_liked
  attr_accessor :user_has_disliked
  belongs_to :user
  has_many :labs
  has_many :likes
  has_many :upvotes
  has_many :tags
  has_many :hypotheses
  has_many :downvotes
  has_many :dislikes
  has_many :lab_files
end
