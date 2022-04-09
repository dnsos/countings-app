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
    @age_groups = AgeGroup.pluck(:min_age, :id)
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to counting_people_url, notice: I18n.t('views.person.update.notice') }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @person.destroy

    respond_to do |format|
      format.html { redirect_to counting_people_url, notice: I18n.t('views.person.destroy.notice') }
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
    params.require(:person).permit(:title, :age_group_id, :gender_id, :pet_count, :counting_id)
  end
end
