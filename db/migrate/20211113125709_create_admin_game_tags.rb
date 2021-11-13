class CreateAdminGameTags < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_game_tags do |t|

      t.integer :game_id, null: false
      t.integer :admin_tag_id, null: false

      t.timestamps
    end
  end
end
