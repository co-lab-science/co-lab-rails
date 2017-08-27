class Searchable
  def self.search(search_term)
    Lab.left_outer_joins(:likes).group("labs.id").select("title", "COUNT(likes.id) AS like_count", :id).where("title LIKE ? OR body LIKE ?", "%#{search_term}%", "%#{search_term}%").order("like_count DESC") + 
    Question.left_outer_joins(:likes).group("questions.id").select("title", "COUNT(likes.id) AS like_count", :id).where("title LIKE ? OR body LIKE ?", "%#{search_term}%", "%#{search_term}%").order("like_count DESC").to_a
  end
end
