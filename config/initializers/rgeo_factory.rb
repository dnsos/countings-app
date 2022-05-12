RGeo::ActiveRecord::SpatialFactoryStore.instance.tap do |config|
  config.default =
    RGeo::Geographic.spherical_factory(
      srid: 4326,
      # https://github.com/rgeo/rgeo/issues/218#issuecomment-731884000
      uses_lenient_assertions: true,
    )
end
