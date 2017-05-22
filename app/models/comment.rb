class Comment < ApplicationRecord
  belongs_to :lab
  belongs_to :hypothesis
  belongs_to :question
end
