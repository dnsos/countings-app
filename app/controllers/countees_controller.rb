require "csv"

class CounteesController < ApplicationController
  before_action :authenticate_admin!, only: %i[index destroy]
  before_action :authenticate_user!, only: %i[new create]

  before_action :set_counting
  before_action :set_countee, only: %i[destroy]

  def index
    respond_to do |format|
      format.html do
        @pagy, @countees = pagy(@counting.countees.order("created_at DESC"))
      end
      format.csv do
        @countees = @counting.countees.all

        response.headers["Content-Type"] = "text/csv"
        response.headers["Content-Disposition"] =
          "attachment; filename=counting-#{@counting.id}_countees.csv"
      end
    end
  end

  def new
    @countee = @counting.countees.build

    @area_assignment =
      current_user
        .counting_signups
        .where(counting: @counting)
        .first
        .area_assignments
        .where(counting_area_id: params[:counting_area_id])
        &.first
    @countee.counting_area_id = @area_assignment&.counting_area_id
  end

  def create
    @countee = @counting.countees.build(countee_params)

    respond_to do |format|
      if @countee.save
        flash.now.notice = I18n.t("countees.create.notice")
        format.turbo_stream

        format.html do
          redirect_to new_counting_countee_url(@counting),
            notice: I18n.t("countees.create.notice")
        end
      else
        flash.now.alert = I18n.t("common.error")

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "countee_form",
              partial: "countees/form",
              locals: {
                countee: @countee
              }
            ),
            turbo_stream.replace(
              "flash",
              partial: "shared/global_flash",
              collection: [flash],
              as: :flash
            )
          ]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @countee.destroy

    respond_to do |format|
      format.html do
        redirect_to counting_countees_url,
          notice: I18n.t("countees.destroy.notice")
      end
    end
  end

  private

  def set_counting
    @counting = Counting.find(params[:counting_id])
  end

  def set_countee
    @countee = @counting.countees.find(params[:id])
  end

  def countee_params
    params
      .require(:countee)
      .permit(
        :counting_id,
        :counting_area_id,
        :gender_id,
        :age_group_id,
        :pet_count
      )
  end
end
