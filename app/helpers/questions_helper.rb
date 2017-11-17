module QuestionsHelper
  def find_question_questions
    if @related_questions == []
      if question_parent?
        [Question.find(@question.parent)]
      else
        question_array
      end
    else
      @related_questions
    end
  end

  def find_question_hypotheses
    if @question.hypotheses == []
      find_parent_lab.hypotheses.compact
    else
      @question.hypotheses
    end
  end

  def find_question_observations
    if @question.labs == []
      [find_parent_lab]
    else
      @question.labs
    end
  end

  def question_parent?
    @question.parent != nil
  end

  def find_parent_lab
    Lab.find(@question.lab_id)
  end

  def question_array
    find_parent_lab.questions.map { |q| q if q.id != @question.id }.compact
  end
end
