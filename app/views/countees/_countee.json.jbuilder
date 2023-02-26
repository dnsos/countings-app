json.extract! countee,
  :id,
  :counting_id,
  :counting_area_id,
  :gender_id,
  :age_group_id,
  :pet_count,
  :created_at,
  :updated_at
json.url countee_url(countee, format: :json)
