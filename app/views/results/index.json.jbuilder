json.array!(@results) do |result|
  json.extract! result, :id, :game, :team, :quarter, :points
  json.url result_url(result, format: :json)
end
