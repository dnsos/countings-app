class CountingsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create edit update destroy]
  before_action :set_counting, only: %i[show edit update destroy]

  def index
    @countings =
      if params[:status].present? && counting_status == "past"
        Counting.past.closest_first
      else
        Counting.upcoming.closest_first
      end
    @counting_status = counting_status
  end

  def show
  end

  def new
    @counting = Counting.new
  end

  def edit
  end

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

  def destroy
    @counting.destroy

    respond_to do |format|
      format.html do
        redirect_to countings_url, notice: I18n.t("countings.destroy.notice")
      end
    end
  end

  private

  def set_counting
    @counting = Counting.find(params[:id])
  end

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

  def counting_status
    params[:status].presence_in(%w[upcoming past]) || "upcoming"
  end
end
