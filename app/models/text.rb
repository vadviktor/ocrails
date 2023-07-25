# frozen_string_literal: true

class Text < ApplicationRecord
  include Orderable
  include Enableable

  belongs_to :image

  validates :text, :svg_polygon_points, presence: true

  scope :ordered, -> { order(position: :asc) }

  private

  def last_position
    image.texts.maximum(:position) || 0
  end
end
