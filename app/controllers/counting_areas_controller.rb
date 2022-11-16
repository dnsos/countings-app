class CountingAreasController < ApplicationController
  before_action :authenticate_admin!

  before_action :set_counting

  def index
    @counting_areas = @counting.counting_areas
  end

  private

  def set_counting
    @counting = Counting.find(params[:counting_id])
  end
end
