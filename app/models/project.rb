class Project < ApplicationRecord
  has_many :images, dependent: :destroy

  validates_presence_of :name, :internal_id
  validates_uniqueness_of :internal_id, message: ->(object, data) { "Project name #{data[:value]} (or a very similar) is already taken." }

  before_validation :generate_internal_id

  def processed_images_in_order
    images&.in_order&.processed
  end

  private

  def generate_internal_id
    self.internal_id = name.parameterize
  end
end
