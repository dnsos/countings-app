# People controller (connected to Person model)
class PeopleController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_counting
  before_action :set_person, only: %i[edit update destroy]

  def index
    @people = @counting.people.order('created_at DESC')
  end

  def edit
    @genders = Gender.pluck("label_#{locale}", :id)
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html do
          redirect_to counting_people_url,
                      notice: I18n.t('views.person.update.notice')
        end
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @person.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @person.destroy

    respond_to do |format|
      format.html do
        redirect_to counting_people_url,
                    notice: I18n.t('views.person.destroy.notice')
      end
      format.json { head :no_content }
    end
  end

  private

  def set_counting
    @counting = Counting.find(params[:counting_id])
  end

  def set_person
    @person = @counting.people.find(params[:id])
  end

  def person_params
    params
      .require(:person)
      .permit(:title, :age_group_id, :gender_id, :pet_count, :counting_id)
  end
end
