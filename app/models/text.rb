class Text < ApplicationRecord
  belongs_to :image

  validates :text, :svg_polygon_points, presence: true
end
