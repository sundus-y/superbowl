class AddFullDateToGames < ActiveRecord::Migration
  def change
    add_column :games, :full_date, :string
  end
end
