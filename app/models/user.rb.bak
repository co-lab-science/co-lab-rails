class User < ApplicationRecord
  has_many :labs
  has_many :comments
  has_many :hypotheses
  has_many :questions
  has_many :specialities
  has_many :votes
  has_many :authorizations
  belongs_to :group

  accepts_nested_attributes_for :specialities

  include BCrypt
  has_secure_password
  validates_uniqueness_of :email

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

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

  def add_provider(auth_hash)
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
  end
end
