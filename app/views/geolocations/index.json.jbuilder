json.set! :type, 'FeatureCollection'
json.set! :features do
  json.array! @districts_with_stats,
              partial: 'geolocations/geolocation',
              as: :geolocations
end
