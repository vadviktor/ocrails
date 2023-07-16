class TextsController < ApplicationController
  before_action :get_text, :get_image

  def position_up
    @text.move_higher
    trigger_htmx
    render_template
  end

  def position_down
    @text.move_lower
    trigger_htmx
    render_template
  end

  def toggle_enabled
    @text.toggle!
    trigger_htmx
    render_template
  end

  private

  def get_text
    @text = Text.find(params[:text_id])
  end

  def get_image
    @image = Image.find(params[:id])
  end

  def render_template
    render template: "projects/show/texts_list", layout: false
  end

  def trigger_htmx
    response.set_header("HX-Trigger", "textUpdated")
  end
end
