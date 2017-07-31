class AddQuestionRefToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_reference :questions, :question, foreign_key: true
  end
end
