# This is a custom validator that ensures that the latitude and longitude of a countee find the associated district.
class Countee::Validator::DistrictValidator < ActiveModel::Validator
  def validate(countee)
    has_latitude_longitude =
      countee.latitude.present? && countee.longitude.present?

    containing_districts =
      District.contains_point?(countee.latitude.to_f, countee.longitude.to_f)

    unless has_latitude_longitude
      # First, clear out the default error for a non-existent, required association:
      countee.errors.delete(:district)

      # Instead, get more precise:
      countee.errors.add :district,
                         :no_lat_lon,
                         message:
                           I18n.t(
                             'activerecord.errors.models.countee.attributes.district.no_lat_lon',
                           )
    end

    if has_latitude_longitude && containing_districts.empty?
      # First, clear out the default error for a non-existent, required association:
      countee.errors.delete(:district)

      # Instead, get more precise:
      countee.errors.add :district,
                         :none_found,
                         message:
                           I18n.t(
                             'activerecord.errors.models.countee.attributes.district.none_found',
                           )
    end

    if has_latitude_longitude && containing_districts.length > 1
      # First, clear out the default error for a non-existent, required association:
      countee.errors.delete(:district)

      # Instead, get more precise:
      countee.errors.add :district,
                         :not_one,
                         message:
                           I18n.t(
                             'activerecord.errors.models.countee.attributes.district.not_one',
                           )
    end
  end
end
