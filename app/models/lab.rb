class Lab < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :hypotheses
  has_many :tags
  has_many :downvotes
  has_many :upvotes
  has_many :likes
  has_many :dislikes

end

