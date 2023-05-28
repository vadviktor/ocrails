class Project < ApplicationRecord
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]
  end

  validates_presence_of :name, :internal_id
  validates_uniqueness_of :internal_id, message: ->(object, data) { "Project name #{data[:value]} (or a very similar) is already taken." }

  before_validation :generate_internal_id

  private

  def generate_internal_id
    self.internal_id = name.parameterize
  end
end
