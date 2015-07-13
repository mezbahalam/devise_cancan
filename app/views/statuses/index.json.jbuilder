json.array!(@statuses) do |status|
  json.extract! status, :id, :post
  json.url status_url(status, format: :json)
end
