RGeo::ActiveRecord::SpatialFactoryStore.instance.tap do |config|
  # https://github.com/rgeo/rgeo/issues/218#issuecomment-731884000
  config.default =
    RGeo::Geographic.spherical_factory(uses_lenient_assertions: true)
end
