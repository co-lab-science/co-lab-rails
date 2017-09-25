class Searchable
  def self.search(search_term)
    Lab.left_outer_joins(:upvotes, :downvotes, :tags).group("labs.id").select("labs.*", "title", "COUNT(DISTINCT upvotes.id) AS upvote_count", :id).where("tags.name ILIKE ? OR title ILIKE ? OR body ILIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%").group("labs.id") +
    Hypothesis.left_outer_joins(:upvotes, :downvotes, :likes, :tags).group("hypotheses.id").select("hypotheses.*", "title","COUNT(DISTINCT upvotes.id) AS upvote_count", "COUNT(DISTINCT likes.id) AS like_count", :id).where("tags.name ILIKE ? OR title ILIKE ? OR body ILIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%").group("hypotheses.id") +
    Question.left_outer_joins(:upvotes, :downvotes, :tags).group("questions.id").select("questions.*","title", "COUNT(DISTINCT upvotes.id) AS upvote_count", :id).where("tags.name ILIKE ? OR title ILIKE ? OR body ILIKE ?", "%#{search_term}%","%#{search_term}%", "%#{search_term}%").group("questions.id").to_a
  end
end
