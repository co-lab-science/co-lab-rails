class CreateSpecialities < ActiveRecord::Migration[5.0]
  def change
    create_table :specialities do |t|
      t.string :category
      t.integer :rank
      t.integer :user_id

      t.timestamps
    end
  end
end
