class RemoveDateFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :date, :string
  end
end
