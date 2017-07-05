class Tag < ApplicationRecord
  belongs_to :lab, required: false
  belongs_to :hypothesis, required: false
end
