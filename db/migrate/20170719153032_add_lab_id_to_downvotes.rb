class AddLabIdToDownvotes < ActiveRecord::Migration[5.0]
  def change
    add_column :downvotes, :lab_id, :integer
  end
end
