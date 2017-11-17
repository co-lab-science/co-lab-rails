module LabsHelper
  def find_lab_observations
    if @related_observations == []
      if lab_parent?
        [Lab.find(@lab.parent)]
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
        Lab.find(@lab.parent).questions
      else
        []
      end
    else
      @lab.questions
    end
  end

  def find_lab_hypotheses
      @lab.hypotheses
  end

  def lab_parent?
    @lab.parent != nil
  end
end
