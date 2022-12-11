class AreaAssignmentsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_counting

  def user
    @current_counting_signup =
      CountingSignup.find_by(user: current_user, counting: @counting)

    @unsorted_area_assignments =
      AreaAssignment.where(counting_signup: @current_counting_signup)

    # TODO: improve the sorting stuff (more concise)
    if params[:counting_area_id]
      quoted_counting_area_id =
        ActiveRecord::Base.connection.quote(params[:counting_area_id])

      @sorted_area_assignments =
        @unsorted_area_assignments.order(
          Arel.sql(
            "CASE WHEN (counting_area_id = #{quoted_counting_area_id}::integer) THEN 0 ELSE 1 END ASC, id",
          ),
        )

      @pagy, @area_assignments =
        pagy(@sorted_area_assignments, items: 1, cycle: true)
    else
      @pagy, @area_assignments =
        pagy(@unsorted_area_assignments, items: 1, cycle: true)
    end
  end

  def create
    @area_assignment = AreaAssignment.new(area_assignment_params)

    # TODO: WIP: respond properly (+ tests etc.)
    respond_to { @area_assignment.save }
  end

  private

  def set_counting
    @counting = Counting.find(params[:counting_id])
  end

  def area_assignment_params
    params
      .require(:area_assignment)
      .permit(:counting_area_id, :counting_signup_id)
  end
end
