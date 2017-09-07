class AddQuestionIdToLabs < ActiveRecord::Migration[5.0]
  def change
    add_column :labs, :question_id, :integer
    add_column :questions, :parent, :integer
  end
end
