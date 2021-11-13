class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|

      t.integer :admin_id, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.integer :admin_rating, null: false

      t.timestamps
    end
  end
end
