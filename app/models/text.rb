class Text < ApplicationRecord
  belongs_to :image
  acts_as_list scope: :image

  validates :text, :svg_polygon_points, presence: true
end
