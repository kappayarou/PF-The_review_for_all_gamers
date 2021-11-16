class AdminGameTag < ApplicationRecord

  belongs_to :game
  belongs_to :admin_tag

end
