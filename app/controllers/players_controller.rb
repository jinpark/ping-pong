class PlayersController < ApplicationController
 
  def all
    Player.ranked
  end

end
