class CreateDownvotes < ActiveRecord::Migration[5.0]
  def change
    create_table :downvotes do |t|
      t.integer :user_id
      t.integer :comment_id
      t.integer :question_id
      t.integer :hypothesis_id

      t.timestamps
    end
  end
end
