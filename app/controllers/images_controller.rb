# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :get_image

  def show
    @project = @image.project
    populate_images
    get_image_dimensions
    render template: 'projects/show'
  end

  def overlay
    get_image_dimensions
    render template: 'projects/show/overlay', layout: false
  end

  def position_up
    @image.move_higher
    populate_images
    render template: 'projects/show/aside', layout: false
  end

  def position_down
    @image.move_lower
    populate_images
    render template: 'projects/show/aside', layout: false
  end

  def destroy
    project = @image.project
    @image.destroy
    redirect_to project_path(project), status: :see_other
  end

  def texts
    render template: 'projects/show/combined_text_pane', layout: false
  end

  private

  def get_image
    @image = Image.find(params[:id])
  end

  def populate_images
    @images = @image.project.processed_images_in_order
  end

  def get_image_dimensions
    @target_width = BigDecimal('800')
    @target_width_ratio = @target_width / @image.document.metadata['width']
    @image_display_width = (@image.document.metadata['width'] * @target_width_ratio).round
    @image_display_height = (@image.document.metadata['height'] * @target_width_ratio).round
  end
end
