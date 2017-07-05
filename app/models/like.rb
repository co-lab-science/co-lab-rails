class Like < ApplicationRecord
  belongs_to :user
  belongs_to :hypothesis, required: false
end
