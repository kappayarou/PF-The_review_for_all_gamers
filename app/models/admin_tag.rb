class AdminTag < ApplicationRecord

  has_many :admin_game_tags, dependent: :destroy

end
