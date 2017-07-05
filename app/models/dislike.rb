class Dislike < ApplicationRecord
  belongs_to :user
  belongs_to :hypothesis, required: false
end
