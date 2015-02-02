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

  def self.winner_game(i,j,q)
    return true if i==0 && j==0 && q==1
    return true if i==4 && j==4 && q==2
    return true if i==4 && j==4 && q==3
    return true if i==8 && j==4 && q==4
    return false
  end
end
