class CreateLabFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :lab_files do |t|
      t.string :name
      t.string :url
      t.integer :lab_id
      t.string :hypothesis_id
      t.string :integer
      t.string :question_id
      t.string :integer

      t.timestamps
    end
  end
end
