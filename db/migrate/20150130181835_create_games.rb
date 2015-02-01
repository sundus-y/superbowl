class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :year
      t.string :desc

      t.timestamps null: false
    end
  end
end
