class RemoveTeamFromResults < ActiveRecord::Migration
  def change
    remove_column :results, :team, :integer
  end
end
