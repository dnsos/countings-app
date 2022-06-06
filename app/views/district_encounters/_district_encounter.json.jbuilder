json.properties do
  json.set! :id, district_encounters.id
  json.set! :name, district_encounters.name
  json.set! :people_count, district_encounters.people_count
end
json.geometry RGeo::GeoJSON.encode(district_encounters.geometry)
