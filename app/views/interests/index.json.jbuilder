json.array!(@interests) do |interest|
  json.extract! interest, :id, :title, :description
  json.url interest_url(interest, format: :json)
end
