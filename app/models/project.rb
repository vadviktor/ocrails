class Project < ApplicationRecord
  validates_presence_of :name, :internal_id
  validates_uniqueness_of :internal_id

  before_validation :generate_internal_id

  private

  def generate_internal_id
    self.internal_id = name.parameterize
  end
end
