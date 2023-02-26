# Countings controller
class CountingsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create edit update destroy]
  before_action :set_counting, only: %i[show edit update destroy]

  # GET /countings or /countings.json
  def index
    @countings =
      if params[:status].present? && counting_status == "past"
        Counting.past
      else
        Counting.upcoming
      end
    @counting_status = counting_status
  end

  # GET /countings/1 or /countings/1.json
  def show
  end

  # GET /countings/new
  def new
    @counting = Counting.new
  end

  # GET /countings/1/edit
  def edit
  end

  # POST /countings
  def create
    @counting = Counting.new(counting_params)
    @counting.user_id = @current_user.id

    respond_to do |format|
      if @counting.save
        format.html do
          redirect_to counting_url(@counting),
            notice: I18n.t("countings.create.notice")
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /countings/1
  def update
    respond_to do |format|
      if @counting.update(counting_params)
        format.html do
          redirect_to counting_url(@counting),
            notice: I18n.t("countings.update.notice")
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /countings/1
  def destroy
    @counting.destroy

    respond_to do |format|
      format.html do
        redirect_to countings_url, notice: I18n.t("countings.destroy.notice")
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_counting
    @counting = Counting.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def counting_params
    params
      .require(:counting)
      .permit(
        :title,
        :description_short,
        :description_long,
        :starts_at,
        :ends_at
      )
  end

  # Make sure that only allowed sort parameters come through. If invalid param is provided, defaults to using "upcoming"
  def counting_status
    params[:status].presence_in(%w[upcoming past]) || "upcoming"
  end
end
