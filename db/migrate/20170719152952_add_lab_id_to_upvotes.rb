class AddLabIdToUpvotes < ActiveRecord::Migration[5.0]
  def change
    add_column :upvotes, :lab_id, :integer
  end
end
