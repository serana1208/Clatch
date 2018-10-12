json.extract! info, :id, :title, :content, :limit, :filename, :created_at, :updated_at
json.url info_url(info, format: :json)
