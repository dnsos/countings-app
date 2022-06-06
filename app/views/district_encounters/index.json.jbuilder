json.set! :type, 'FeatureCollection'
json.set! :features do
  json.array! @districts_with_stats,
              partial: 'district_encounters/district_encounter',
              as: :district_encounters
end
