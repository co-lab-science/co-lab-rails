module SearchHelper
  def find_parent(id = nil, type = nil)
    if type == nil
      false
    else
      case type
      when "Lab"
        Lab.find(id)
      when "Question"
        Question.find(id)
      when "Hypothesis"
        Hypothesis.find(id)
      end
    end
  end
end
