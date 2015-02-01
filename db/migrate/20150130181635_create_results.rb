class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :game
      t.integer :team
      t.integer :quarter
      t.integer :points

      t.timestamps null: false
    end
  end
end
