class AreaAssignmentsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_counting

  def user
    @pagy, @area_assignments =
      pagy(
        AreaAssignment.where(
          counting_signup: CountingSignup.find(current_user.id).id,
        ),
        items: 1,
      )
  end

  private

  def set_counting
    @counting = Counting.find(params[:counting_id])
  end
end
