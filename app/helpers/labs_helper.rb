module LabsHelper
  def timeline
    [find_lab_observations, find_lab_questions, find_lab_hypotheses].flatten.sort_by(&:created_at).reverse
  end

  def find_lab_observations
    if @related_observations == []
      if lab_parent?
        Lab.where(parent: @lab.id)
      else
        []
      end
    else
      @related_observations
    end
  end

  def find_lab_questions
    if @lab.questions == []
      if lab_parent?
        Question.where(lab_id: @lab.id)
      else
        []
      end
    else
      @lab.questions
    end
  end

  def find_lab_hypotheses
      Hypothesis.where(lab_id: @lab.id)
  end

  def lab_parent?
    @lab.parent != nil
  end

  def format_date(date)
    d = date.to_date.to_s.split("-")
    "#{d[1]}/#{d[2]}/#{d[0]}"
  end
end
