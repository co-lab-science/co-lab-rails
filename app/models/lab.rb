class Lab < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :hypotheses
  has_many :tags
  has_many :downvotes
  has_many :upvotes

  def self.search(search_term, page)
    where("title LIKE ? OR body LIKE ?", "%#{search_term}%", "%#{search_term}%")
      .paginate(per_page: 50, page: page)
  end
end
