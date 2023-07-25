# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :images, dependent: :destroy

  validates :name, :internal_id, presence: true
  validates :internal_id, uniqueness: { message: lambda { |_object, data|
                                                   "Project name #{data[:value]} (or a very similar) is already taken."
                                                 } }

  before_validation :generate_internal_id

  def processed_images_in_order
    images&.ordered&.processed
  end

  private

  def generate_internal_id
    self.internal_id = name.parameterize
  end
end
