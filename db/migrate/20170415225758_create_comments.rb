class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :title
      t.text :body
      t.integer :vote_count
      t.integer :lab_id
      t.integer :hypothesis_id
      t.integer :question_id
      t.integer :user_id

      t.timestamps
    end
  end
end
