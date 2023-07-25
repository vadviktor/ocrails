# frozen_string_literal: true

class TextsController < ApplicationController
  before_action :text, :image

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

  def text
    @text = Text.find(params[:text_id])
  end

  def image
    @image = Image.find(params[:id])
  end

  def render_template
    render template: 'projects/show/texts_list', layout: false
  end

  def trigger_htmx
    response.set_header('HX-Trigger', 'textUpdated')
  end
end
