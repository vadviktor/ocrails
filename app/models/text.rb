class Text < ApplicationRecord
  include Orderable
  belongs_to :image

  validates :text, :svg_polygon_points, presence: true

  scope :in_order, -> { order(position: :asc) }

  private

  def last_position
    image.texts.maximum(:position) || 0
  end
end
