json.type 'Feature'
json.properties { json.extract! counting_area, :id, :name }
json.geometry RGeo::GeoJSON.encode(counting_area.geometry)
