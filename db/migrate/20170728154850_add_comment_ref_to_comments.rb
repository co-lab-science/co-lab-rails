class AddCommentRefToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :comment_id, :string
    add_column :comments, :references, :string
  end
end
