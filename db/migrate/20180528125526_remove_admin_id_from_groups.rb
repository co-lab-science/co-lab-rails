class RemoveAdminIdFromGroups < ActiveRecord::Migration[5.0]
  def change

    remove_column :groups, :admin_id, :integer
  end
end
