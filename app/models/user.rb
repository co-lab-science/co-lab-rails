class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :labs
  has_many :comments
  has_many :hypotheses
  has_many :questions
  has_many :specialities
  has_many :votes
  has_many :authorizations
  belongs_to :group

  accepts_nested_attributes_for :specialities

  def group=(id)
    if id != "1"
      Group.find(id.to_i).user_requesting_access(self.id)
      self.requested_group = id.to_i
      self.save
    end
    self.group_id = 1
    self.save
  end

  def requested_group_obj
    Group.find(self.requested_group) if self.requested_group
  end

  def all_groups
    if self.group == nil
      [Group.first]
    else
      [self.group, Group.first].compact.uniq
    end
  end

end
