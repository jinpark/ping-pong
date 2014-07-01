class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :lost_games, :class_name => 'Match', :foreign_key => 'loser_id'
  has_many :won_games, :class_name => 'Match', :foreign_key => 'winner_id'

  def games
    games_scope = Match.where('loser_id = ? OR winner_id = ?', self.id, self.id)

    games_scope
  end
end
