class AddHypothesisToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :hypothesis_id, :integer
  end
end
