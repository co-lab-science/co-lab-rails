class AddQuestionRefToHypotheses < ActiveRecord::Migration[5.0]
  def change
    add_reference :hypotheses, :question, foreign_key: true
  end
end
