class Project < ApplicationRecord
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]
  end

  validates_presence_of :name, :internal_id
  validates_uniqueness_of :internal_id, message: ->(object, data) { "Project name #{data[:value]} (or a very similar) is already taken." }
  validate :image_maximum_size

  before_validation :generate_internal_id
  after_validation :clean_up_images

  private

  def generate_internal_id
    self.internal_id = name.parameterize
  end

  def image_maximum_size
    images.each do |image|
      if image.blob.byte_size > 5.megabytes
        errors.add(:images, "Image #{image.filename} is too big")
      end
    end
  end

  def clean_up_images
    ActiveStorage::Blob.unattached.find_each(&:purge_later)
  end
end
