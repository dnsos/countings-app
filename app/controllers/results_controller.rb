class ResultsController < ApplicationController
  before_action :set_counting

  def counting_area
    @counting_area_results =
      CountingArea.find_by_sql [
                                 'SELECT counting_areas.name, COUNT(countees.*) AS countees_count FROM counting_areas JOIN countees ON countees.counting_area_id = counting_areas.id WHERE countees.counting_id = ? GROUP BY counting_areas.name',
                                 result_params[:counting_id],
                               ]
  end

  def gender
    @gender_results =
      Gender.find_by_sql [
                           'SELECT genders.*, COUNT(countees.*) AS countees_count FROM genders JOIN countees ON countees.counting_area_id = genders.id WHERE countees.counting_id = ? GROUP BY genders.id',
                           result_params[:counting_id],
                         ]
  end

  def age_group
    @age_group_results =
      AgeGroup.find_by_sql [
                             'SELECT age_groups.*, COUNT(countees.*) AS countees_count FROM age_groups JOIN countees ON countees.counting_area_id = age_groups.id WHERE countees.counting_id = ? GROUP BY age_groups.id',
                             result_params[:counting_id],
                           ]
  end

  def set_counting
    @counting = Counting.find(params[:counting_id])
  end

  def result_params
    params.permit(:counting_id)
  end
end
