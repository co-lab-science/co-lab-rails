class RemoveAdminFromGroups < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups, :admin, :string
  end
end
