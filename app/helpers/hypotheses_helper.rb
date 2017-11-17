module HypothesesHelper
  def find_hypothesis_hypotheses
    if @related_hypotheses == []
      if hypothesis_parent?
        [Hypothsis.find(@hypothesis.parent)]
      else
        hypotheses_array
      end
    else
      @related_hypotheses
    end
  end

  def find_hypothesis_questions
    find_hypothesis_parent_lab.questions.compact
  end

  def find_hypothesis_observations
    [find_hypothesis_parent_lab]
  end

  def hypothesis_parent?
    @hypothesis.parent != nil
  end

  def find_hypothesis_parent_lab
    Lab.find(@hypothesis.lab_id)
  end

  def hypotheses_array
    find_hypothesis_parent_lab.hypotheses.map { |h| h if h.id != @hypothesis.id }.compact
  end
end
