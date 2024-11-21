json.extract! plant, :id, :HectareId, :humidity, :growthMm, :heatJoules, :steamThicknessMm, :pestPresence, :texture, :oxygenationLevel, :created_at, :updated_at
json.url plant_url(plant, format: :json)
