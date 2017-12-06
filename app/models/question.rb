class Question < ApplicationRecord
  attr_accessor :user_has_upvoted
  attr_accessor :user_has_downvoted
  attr_accessor :user_has_liked
  attr_accessor :user_has_disliked
  belongs_to :user
  has_many :labs
  has_many :likes
  has_many :upvotes
  has_many :tags
  has_many :hypotheses
  has_many :downvotes
  has_many :dislikes
  has_many :lab_files

  def like_count
    0
  end

  def get_associated_posts
    if associated_posts_hash.values.flatten.empty?
      if self.lab_id != nil && Lab.find_by_id(self.lab_id) != nil
        Lab.find(self.lab_id).get_associated_posts
      elsif self.hypothesis_id != nil && Hypothesis.find_by_id(self.hypothesis_id) != nil
        Hypothesis.find(self.hypothesis_id).get_associated_posts
      else
        associated_posts_hash
      end
    else
      associated_posts_hash
    end
  end

  def associated_posts_hash
    {
      observations: self.get_observations.flatten.compact,
      questions: self.get_questions.flatten.compact,
      hypotheses: self.get_hypotheses.flatten.compact
    }
  end

  def find_parent
    Question.find(self.parent) unless self.parent == nil
  end

  def get_observations
    self.labs.empty? ? [self.find_parent.nil? ? nil : self.find_parent.labs] : [self.labs]
  end

  def get_questions
    [self.related_questions, self.find_parent].flatten
  end

  def get_hypotheses
    self.hypotheses.empty? ? [self.find_parent.nil? ? nil : self.find_parent.hypotheses] : [self.hypotheses]
  end

  def related_questions
    Question.where(parent: self.id).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("questions.*", "COUNT(DISTINCT upvotes.id) as upvote_count", "COUNT(DISTINCT downvotes.id) as downvote_count", "users.name as fullname", "users.id as user_id").group(:id, "users.id","fullname")
  end

end
