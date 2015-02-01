class RemoveYearFromGame < ActiveRecord::Migration
  def change
    remove_column :games, :year, :integer
  end
end
