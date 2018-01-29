class Group < ApplicationRecord
  has_many :labs
  has_many :hypotheses
  has_many :questions
  has_many :users

  def members
    self.users
  end

  def admin
    if self.admin_id
      User.find(self.admin_id)
    else
      nil
    end
  end

  def admin=(user)
    self.admin_id = user.id
    self.save
  end

  def name_with_access
    if self.id == 1
      self.name
    else
      "#{self.name} - REQUIRES APPROVAL"
    end
  end

  def users_requesting_access
    User.where(requested_group: self.id)
  end

end
