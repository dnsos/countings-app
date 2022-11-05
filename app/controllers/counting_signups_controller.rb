class CountingSignupsController < ApplicationController
  before_action :authenticate_admin!, only: %i[index]
  before_action :authenticate_user!, only: %i[create destroy]

  before_action :set_counting
  before_action :set_counting_signup

  def index; end

  def create
    @counting_signup =
      CountingSignup.new(
        counting_id: counting_signup_params[:counting_id],
        user_id: current_user.id,
      )

    respond_to do |format|
      if @counting_signup.save
        format.html do
          redirect_to counting_url(@counting),
                      notice: I18n.t('counting_signups.create.notice')
        end
      else
        format.html { render 'countings/show', status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @counting_signup.destroy

    respond_to do |format|
      format.html do
        redirect_to counting_url(@counting),
                    notice: I18n.t('counting_signups.destroy.notice')
      end
    end
  end

  private

  def set_counting
    @counting = Counting.find(counting_signup_params[:counting_id])
  end

  def set_counting_signup
    @counting_signup =
      @counting.counting_signups.find_by(user_id: current_user.id)
  end

  def counting_signup_params
    params.permit(:counting_id)
  end
end
