class AddLabIdToLikeAndDislikeTable < ActiveRecord::Migration[5.0]
  def change
    add_column :likes, :lab_id, :integer
    add_column :dislikes, :lab_id, :integer
    add_column :likes, :question_id, :integer
    add_column :dislikes, :question_id, :integer
  end
end
