class ChangeDefaultRanking < ActiveRecord::Migration
  def change
  	change_column :players, :rating, :integer, :default => 0
  end
end
