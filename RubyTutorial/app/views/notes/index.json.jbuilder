json.array!(@notes) do |note|
  json.extract! note, :id, :contect, :user_id, :restaurant_id
  json.url note_url(note, format: :json)
end
