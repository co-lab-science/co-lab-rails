class LabFile < ApplicationRecord
  belongs_to :lab, required: false
  belongs_to :hypothesis, required: false
  belongs_to :questions, required: false
end
