class AreaAssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, except: %i[user]

  before_action :set_counting
  before_action :set_area_assignment, only: %i[edit update destroy]

  # TODO: It's probably not ideal to load counting_signups and counting_areas
  # on every create. They are actually only needed when there is an error and
  # the form needs to be displayed again. Better solution?
  before_action :set_counting_signups, only: %i[new create edit destroy]
  before_action :set_counting_areas, only: %i[new create destroy]

  def index
    @associated_counting_areas = CountingArea.where(counting: @counting)
    @area_assignments =
      AreaAssignment.where(counting_area: @associated_counting_areas)
  end

  def user
    user_counting_signup =
      CountingSignup.find_by(user: current_user, counting: @counting)

    @area_assignments = AreaAssignment.where(counting_signup: user_counting_signup)

    if params[:counting_area_id]
      quoted_counting_area_id =
        ActiveRecord::Base.connection.quote(params[:counting_area_id])

      @area_assignments = @area_assignments.order(
        Arel.sql(
          "CASE WHEN (counting_area_id = #{quoted_counting_area_id}::integer) THEN 0 ELSE 1 END ASC, id"
        )
      )
    end

    @pagy, @area_assignments = pagy(@area_assignments, items: 1, cycle: true)
  end

  def new
    @area_assignment =
      AreaAssignment.new(counting_area_id: @initial_counting_area)
  end

  def create
    @area_assignment = AreaAssignment.new(area_assignment_params)

    respond_to do |format|
      if @area_assignment.save
        flash.now.notice = I18n.t("area_assignments.create.notice")
        format.turbo_stream

        format.html do
          redirect_to edit_counting_area_assignment_url(
            @counting,
            @area_assignment
          ),
            notice: I18n.t("area_assignments.create.notice")
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    # Assignable are all yet unassigned areas, plus the area that is currently assigned:
    @assignable_counting_areas =
      @counting
        .counting_areas
        .where
        .missing(:area_assignment)
        .or(AreaAssignment.where(id: params[:id]))
  end

  def update
    respond_to do |format|
      if @area_assignment.update(area_assignment_params)
        flash.now.notice = I18n.t("area_assignments.update.notice")
        format.turbo_stream

        format.html do
          redirect_to edit_counting_area_assignment_url(
            @counting,
            @area_assignment
          ),
            notice: I18n.t("area_assignments.update.notice")
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @area_assignment.destroy

    respond_to do |format|
      flash.now.notice = I18n.t("area_assignments.destroy.notice")
      format.turbo_stream

      format.html do
        redirect_to new_counting_area_assignment_url(@counting),
          notice: I18n.t("area_assignments.destroy.notice")
      end
    end
  end

  private

  def set_counting
    @counting = Counting.find(params[:counting_id])
  end

  def set_area_assignment
    @area_assignment = AreaAssignment.find(params[:id])
  end

  def set_counting_signups
    @counting_signups = @counting.counting_signups
  end

  def set_counting_areas
    @assignable_counting_areas =
      @counting.counting_areas.where.missing(:area_assignment)

    # If valid counting_area_id is given, we can set that one as selected:
    @initial_counting_area =
      if params[:counting_area_id].present? &&
          @assignable_counting_areas.ids.include?(
            params[:counting_area_id].to_i
          )
        params[:counting_area_id]
      end
  end

  def area_assignment_params
    params.require(:area_assignment).permit(
      :counting_area_id,
      :counting_signup_id
    )
  end
end
