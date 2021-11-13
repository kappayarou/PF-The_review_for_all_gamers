class CreateUserGameTags < ActiveRecord::Migration[5.2]
  def change
    create_table :user_game_tags do |t|

      t.integer :game_id, null: false
      t.integer :user_tag_id, null: false

      t.timestamps
    end
  end
end
