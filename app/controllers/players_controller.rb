class PlayersController < ApplicationController

  def index
    @ranked_players = Player.ranked

    @match = Match.new()

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:winner_id, :loser_id)
    end

end