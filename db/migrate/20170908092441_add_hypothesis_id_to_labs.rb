class AddHypothesisIdToLabs < ActiveRecord::Migration[5.0]
  def change
    add_column :labs, :hypothesis_id, :integer
  end
end
