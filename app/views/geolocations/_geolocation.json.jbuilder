json.set! :id, geolocations.id
json.set! :name, geolocations.name
json.set! :geometry, RGeo::GeoJSON.encode(geolocations.geometry)
json.set! :people_count, geolocations.people_count
