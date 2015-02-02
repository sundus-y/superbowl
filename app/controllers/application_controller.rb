class ApplicationController < ActionController::Base
  require 'open-uri'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def fetch_games
    clean_tables
    setup_teams
    t_se = Team.first
    t_gb = Team.last
    setup_games_and_results(t_gb, t_se)
    redirect_to root_path
  end

  def setup_games_and_results(t_gb, t_se)
    [['all', 'sea'], ['all', 'nwe'], ['sea', 'nwe']].each_with_index do |t, index|
      years = ['2010', '2011', '2012', '2013', '2014']
      years = ['all'] if index == 2
      years.each do |year|
        page = Nokogiri::HTML(open("http://www.pro-football-reference.com/boxscores/game_query.cgi?tm1=#{t.first}&tm2=#{t.last}&yr=#{year}"))
        games_link = page.css('a').select { |a| a.text == 'boxscore' }
        games_link.each do |game|
          game_link = "http://www.pro-football-reference.com/#{game.attributes['href'].value}"
          game = Nokogiri::HTML(open(game_link))
          desc = index == 2 ? "all" : t.last
          g_date = game.css('.float_left.margin_right').first.text
          n_game = Game.new(desc: desc, link: game_link, full_date: g_date)
          n_game.save!
          t_se_point = game.css('table#linescore').css("td[align='right']")[0..3].map(&:text).map(&:to_i)
          t_gb_point = game.css('table#linescore').css("td[align='right']")[5..8].map(&:text).map(&:to_i)
          Result.new_game_result(t_se, n_game, t_se_point)
          Result.new_game_result(t_gb, n_game, t_gb_point)
        end
      end
    end
  end

  def setup_teams
    Team.new(name:'Seattle Seahawks').save!
    Team.new(name:'New England Patriots').save!
  end

  def clean_tables
    Team.delete_all
    Result.delete_all
    Game.delete_all
  end

end
