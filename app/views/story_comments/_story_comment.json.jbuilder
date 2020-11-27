json.extract! story_comment, :id, :body, :story_id, :created_at, :updated_at
json.url story_comment_url(story_comment, format: :json)
