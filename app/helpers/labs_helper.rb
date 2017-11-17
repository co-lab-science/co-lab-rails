module LabsHelper
  def associated_observations
    # binding.pry
    if @related_observations == []
      [Lab.find(@lab.parent)]
    else
      @related_observations
    end
  end

  def associated_questions
    if @lab.questions == []
      Lab.find(@lab.parent).questions
    else
      @lab.questions
    end
  end

  def associated_hypotheses
    if @lab.hypotheses == []
      Lab.find(@lab.parent).hypotheses
    else
      @lab.hypotheses
    end
  end
end
