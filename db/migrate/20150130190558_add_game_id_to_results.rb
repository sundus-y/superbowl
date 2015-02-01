class AddGameIdToResults < ActiveRecord::Migration
  def change
    add_column :results, :game_id, :integer
  end
end
