class ImagesController < ApplicationController
  before_action :get_image, only: %i[position_up position_down]

  def position_up
    @image.move_higher
    redirect_to project_path(@image.project), status: :see_other
  end

  def position_down
    @image.move_lower
    redirect_to project_path(@image.project), status: :see_other
  end

  private

  def get_image
    @image = Image.find(params[:id])
  end
end
