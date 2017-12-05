module QuestionsHelper
  def find_question_questions(question)
    if @related_questions == []
      if question_parent?(question)
        [Question.find(question.parent)]
      else
        question_array(question)
      end
    else
      @related_questions
    end
  end

  def find_question_hypotheses(question)
    if question.hypotheses == []
      find_parent_lab(question).hypotheses.compact
    else
      question.hypotheses
    end
  end

  def find_question_observations(question)
    if question.labs == []
      [find_parent_lab(question)].flatten
    else
      question.labs
    end
  end

  def question_parent?(question)
    question.parent != nil
  end

  def find_parent_lab(question)
    if question.lab_id == nil
      Lab.all.shuffle.first
    else
      Lab.find(question.lab_id)
    end
  end

  def question_array(question)
    find_parent_lab(question).questions.map { |q| q if q.id != question.id }.compact
  end
end
