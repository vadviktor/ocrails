class Text < ApplicationRecord
  belongs_to :project

  validates :text, :svg_polygon_points, presence: true
end
