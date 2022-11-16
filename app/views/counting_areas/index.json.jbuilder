json.type 'FeatureCollection'
json.features do
  json.array! @counting_areas,
              partial: 'counting_areas/counting_area',
              as: :counting_area
end
