class AddTagIdToLab < ActiveRecord::Migration[5.0]
  def change
    add_column :labs, :tag_id, :integer
    add_column :hypotheses, :tag_id, :integer
    add_column :questions, :tag_id, :integer
    add_column :tags, :question_id, :integer
  end
end
