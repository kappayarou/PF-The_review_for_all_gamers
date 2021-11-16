class UserGameTag < ApplicationRecord

  belongs_to :game
  belongs_to :user_tag

end
