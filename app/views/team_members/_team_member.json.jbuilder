json.extract! team_member, :id, :name, :created_at, :updated_at, :avatar
json.url team_member_url(team_member, format: :json)
