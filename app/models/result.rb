class Result < ActiveRecord::Base
  belongs_to :game
  belongs_to :team


  def self.new_game_result(n_team,n_game,n_points)
    n_points.each_with_index do |p,i|
      Result.new(team: n_team,
                 game: n_game,
                 quarter: i+1,
                 points: p+n_points[0..i].reduce(&:+)).save!
    end
  end
end
