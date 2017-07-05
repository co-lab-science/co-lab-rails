class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :lab, required: false
  belongs_to :hypothesis, required: false
  belongs_to :question, required: false
  has_many   :upvotes
  has_many   :downvotes
end
