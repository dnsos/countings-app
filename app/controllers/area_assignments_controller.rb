class AreaAssignmentsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_counting

  def user
    @current_counting_signup =
      CountingSignup.find_by(user: current_user, counting: @counting)

    @area_assignments =
      AreaAssignment.where(counting_signup: @current_counting_signup)

    if params[:counting_area_id]
      quoted_counting_area_id =
        ActiveRecord::Base.connection.quote(params[:counting_area_id])

      @area_assignments =
        @area_assignments.order(
          Arel.sql(
            "CASE WHEN (id = #{quoted_counting_area_id}) THEN 0 ELSE 1 END ASC, id",
          ),
        )
    end

    @pagy, @area_assignments = pagy(@area_assignments, items: 1, cycle: true)
  end

  private

  def set_counting
    @counting = Counting.find(params[:counting_id])
  end
end
