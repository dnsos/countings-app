json.extract! geolocations, :id, :name, :geometry, :people_count

# Singular view of a district with stats is not yet implemented.
# The below is not working correctly:
#json.url counting_geolocations_url(geolocations, format: :json)
