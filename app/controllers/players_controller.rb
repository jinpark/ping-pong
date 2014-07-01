class PlayersController < ApplicationController

  PRO_K_FACTOR = 10
  STARTER_K_FACTOR = 25
  DEFAULT_K_FACTOR = 15

 
  def all
    @players = Player.all
  end

  def calculate_new_rating(score, opponent)
    if self.games.count < 20
      k_value = STARTER_K_FACTOR
    elsif self.rating > 2400
      k_value = PRO_K_FACTOR
    else 
      k_value = DEFAULT_K_FACTOR
    end
        
    new_rating = self.rating + k_value * (score - expected_outcome(opponent))
    self.rating = new_rating
    self.save
  end

  def pro?
    if self.rating > 2400
      True
    else
      False
    end
  end

  def expected_outcome(opponent)
    1.0/(1 + 10**((opponent.rating - self.rating)/400))
  end
end
