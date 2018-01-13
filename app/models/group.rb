class Group < ApplicationRecord
  has_many :labs
  has_many :hypotheses
  has_many :questions
  has_many :users

  def members
    self.users
  end
end
