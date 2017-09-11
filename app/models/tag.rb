class Tag < ApplicationRecord
  has_many :labs
  has_many :hypothesis
  has_many :questions
end
