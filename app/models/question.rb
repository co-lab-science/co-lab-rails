class Question < ApplicationRecord
  belongs_to :lab
  belongs_to :user
  has_many :comments
end
