class AddParentIdToLabs < ActiveRecord::Migration[5.0]
  def change
    add_column :labs, :parent, :integer
  end
end
