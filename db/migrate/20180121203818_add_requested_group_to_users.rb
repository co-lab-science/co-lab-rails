class AddRequestedGroupToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :requested_group, :integer
  end
end
