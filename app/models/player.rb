class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :lost_games, :class_name => 'Match', :foreign_key => 'loser_id'
  has_many :won_games, :class_name => 'Match', :foreign_key => 'winner_id'

  PRO_K_FACTOR = 10
  STARTER_K_FACTOR = 25
  DEFAULT_K_FACTOR = 15


  def games
    games_scope = Match.where('loser_id = ? OR winner_id = ?', self.id, self.id)

    games_scope
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

    self.rating
  end

  def pro?
    if self.rating > 2400
      True
    else
      False
    end
  end

  def self.ranked
    players = Player.all
    sorted_players = players.order('rating DESC')
    grouped_players = sorted_players.group_by{|player| player.rating}
    ranked_players = {}
    grouped_players.values.each_with_index do |players, i|
      ranked_players[i + 1] = players
    end
    ranked_players
  end

  def expected_outcome(opponent)
    1.0/(1 + 10**((opponent.rating - self.rating)/400))
  end
end
