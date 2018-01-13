class AddGroupIdToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :group_id, :integer
  end
end
