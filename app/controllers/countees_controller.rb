class CounteesController < ApplicationController
  before_action :authenticate_admin!, only: %i[edit update destroy]
  before_action :authenticate_user!, only: %i[new create]

  before_action :set_counting
  before_action :set_countee, only: %i[show edit update destroy]

  def index
    @countees = @counting.countees.order('created_at DESC').limit(25)
  end

  def show; end

  def new
    @countee = @counting.countees.build
  end

  def edit; end

  def create
    @countee = @counting.countees.build(countee_params)

    if countee_params[:latitude].present? && countee_params[:longitude].present?
      district =
        District.contains_point?(
          countee_params[:latitude].to_f,
          countee_params[:longitude].to_f,
        ).first

      @countee.district_id = district ? district.id : nil
    end

    respond_to do |format|
      if @countee.save
        # The flash.now makes the message available to the Turbo Stream
        #  which is using it in the current action, not the next.
        flash.now.notice = I18n.t('countees.create.notice')

        # This makes sure that on a successful "create", the corresponding create.turbo_stream.erb view is rendered:
        format.turbo_stream

        format.html do
          redirect_to new_counting_countee_url(@counting),
                      notice: I18n.t('countees.create.notice')
        end
      else
        # The flash.now makes the message available to the Turbo Stream
        #  which is using it in the current action, not the next.
        flash.now.alert = I18n.t('common.error')

        format.turbo_stream do
          render turbo_stream: [
                   turbo_stream.replace(
                     'countee_form',
                     partial: 'countees/form',
                     locals: {
                       countee: @countee,
                     },
                   ),
                   turbo_stream.replace(
                     'flash',
                     partial: 'shared/global_flash',
                     collection: [flash],
                     as: :flash,
                   ),
                 ]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @countee.update(
           # Note that we don't allow updating the counting.
           # It would be illogical to move a countee from
           # one to another, completely separated counting.
           counting_id: @countee.counting_id,
           # Note that we don't allow updating the district_id.
           # It is generated from the latitude and longitude params.
           # Since the idea of not storing them is anonymity,
           # we can also not update from this absent data.
           district_id: @countee.district_id,
           age_group_id: countee_params[:age_group_id],
           gender_id: countee_params[:gender_id],
           pet_count: countee_params[:pet_count],
         )
        format.html do
          redirect_to counting_countee_url(@counting, @countee),
                      notice: I18n.t('countees.update.notice')
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @countee.destroy

    respond_to do |format|
      format.html do
        redirect_to counting_countees_url,
                    notice: I18n.t('countees.destroy.notice')
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
        :latitude,
        :longitude,
        :gender_id,
        :age_group_id,
        :pet_count,
      )
  end
end
