class AddParentToHypothesis < ActiveRecord::Migration[5.0]
  def change
    add_column :hypotheses, :parent, :integer
    add_column :hypotheses, :question_id, :integer
    add_column :hypotheses, :review_id, :integer
  end
end
