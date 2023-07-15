class TextsController < ApplicationController
  before_action :get_text

  def position_up
    @text.move_higher
    @image = @text.image
    trigger_htmx
    render template: "projects/show/texts_list", layout: false
  end

  def position_down
    @text.move_lower
    @image = @text.image
    trigger_htmx
    render template: "projects/show/texts_list", layout: false
  end

  private

  def get_text
    @text = Text.find(params[:text_id])
  end

  def trigger_htmx
    response.set_header("HX-Trigger", "textUpdated")
  end
end
