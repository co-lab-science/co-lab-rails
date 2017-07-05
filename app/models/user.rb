class User < ApplicationRecord
  has_many :labs
  has_many :comments
  has_many :hypotheses
  has_many :questions
  has_many :specialities
  has_many :votes

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
end
