class RemoveGameFromResults < ActiveRecord::Migration
  def change
    remove_column :results, :game, :string
  end
end
