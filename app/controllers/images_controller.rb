class ImagesController < ApplicationController
  before_action :get_image, only: %i[show position_up position_down]

  def show
    @project = @image.project
    populate_images
    render template: "projects/show"
  end

  def position_up
    @image.move_higher
    populate_images
    render template: "projects/show/aside", layout: false
  end

  def position_down
    @image.move_lower
    populate_images
    render template: "projects/show/aside", layout: false
  end

  private

  def get_image
    @image = Image.find(params[:id])
  end

  def populate_images
    @images = @image.project.processed_images_in_order
  end
end
