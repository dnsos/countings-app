# Countings controller
class CountingsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create edit update destroy]
  before_action :set_counting, only: %i[show edit update destroy]

  # GET /countings or /countings.json
  def index
    @countings = Counting.all
  end

  # GET /countings/1 or /countings/1.json
  def show; end

  # GET /countings/new
  def new
    @counting = Counting.new
  end

  # GET /countings/1/edit
  def edit; end

  # POST /countings or /countings.json
  def create
    @counting = Counting.new(counting_params)
    @counting.user_id = @current_user.id

    respond_to do |format|
      if @counting.save
        format.html { redirect_to counting_url(@counting), notice: 'Counting was successfully created.' }
        format.json { render :show, status: :created, location: @counting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @counting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /countings/1 or /countings/1.json
  def update
    respond_to do |format|
      if @counting.update(counting_params)
        format.html { redirect_to counting_url(@counting), notice: 'Counting was successfully updated.' }
        format.json { render :show, status: :ok, location: @counting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @counting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /countings/1 or /countings/1.json
  def destroy
    @counting.destroy

    respond_to do |format|
      format.html { redirect_to countings_url, notice: 'Counting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_counting
    @counting = Counting.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def counting_params
    params.require(:counting).permit(:title, :description, :starts_at, :ends_at)
  end
end
