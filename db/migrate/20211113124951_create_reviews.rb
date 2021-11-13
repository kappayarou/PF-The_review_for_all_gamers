class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|

      t.integer :game_id, null: false
      t.integer :user_id, null: false
      t.text :review, null: false
      t.integer :review_type, null: false

      t.timestamps
    end
  end
end
