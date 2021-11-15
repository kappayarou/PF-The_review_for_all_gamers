class Game < ApplicationRecord
  has_one_attached :image
  has_many :admin_game_tags, dependent: :destroy
  has_many :user_game_tags, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy

  belongs_to :admin

end
