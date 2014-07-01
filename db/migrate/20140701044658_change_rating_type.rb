class ChangeRatingType < ActiveRecord::Migration
  def change
  	change_column :players, :rating, :float, :null => false
  end
end
