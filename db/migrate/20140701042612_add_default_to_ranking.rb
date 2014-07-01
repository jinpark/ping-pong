class AddDefaultToRanking < ActiveRecord::Migration
  def change
  	rename_column :players, :ranking, :rating
  	change_column :players, :rating, :integer, :default => 1000
  end
end
