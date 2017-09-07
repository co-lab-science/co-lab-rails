class AddHypothesisIdToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :hypothesis_id, :integer
  end
end
