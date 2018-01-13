class AddGroupIdToLabs < ActiveRecord::Migration[5.0]
  def change
    add_column :labs, :group_id, :integer
  end
end
