class AddRankingToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :ranking, :integer
  end
end
