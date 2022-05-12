json.properties do
  json.set! :id, geolocations.id
  json.set! :name, geolocations.name
  json.set! :people_count, geolocations.people_count
end
json.geometry RGeo::GeoJSON.encode(geolocations.geometry)
