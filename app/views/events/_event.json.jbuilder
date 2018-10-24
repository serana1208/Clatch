json.extract! event, :id, :content, :eventday, :created_at, :updated_at
json.url event_url(event, format: :json)
