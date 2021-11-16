class UserTag < ApplicationRecord

  has_many :user_game_tags, dependent: :destroy

end
