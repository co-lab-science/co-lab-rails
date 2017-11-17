module LabsHelper
  def observations
    self.instance_variable_get(:@related_observations)
  end

  def hypotheses
      @lab.hypotheses
  end

  def questions
    @lab.questions
  end
end
