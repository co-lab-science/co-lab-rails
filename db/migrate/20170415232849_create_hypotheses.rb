class CreateHypotheses < ActiveRecord::Migration[5.0]
  def change
    create_table :hypotheses do |t|
      t.string :title
      t.string :body
      t.integer :lab_id

      t.timestamps
    end
  end
end
