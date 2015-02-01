json.array!(@games) do |game|
  json.extract! game, :id, :year, :desc
  json.url game_url(game, format: :json)
end
