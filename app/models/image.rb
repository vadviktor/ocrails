class Image < ApplicationRecord
  include Orderable

  belongs_to :project
  has_many :texts, dependent: :destroy

  has_one_attached :document do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]
  end

  validate :document_maximum_size
  after_validation :clean_up_documents

  scope :processed, -> { where(text_extracted: true) }
  scope :unprocessed, -> { where(text_extracted: false) }
  scope :ordered, -> { order(position: :asc) }

  # All the text from the image after the user has ordered the lines and decided which lines to display.
  def full_text
    texts.enabled.ordered.pluck(:text).join("\n").strip
  end

  private

  def last_position
    project.images.maximum(:position) || 0
  end

  def document_maximum_size
    if document.blob.byte_size > 5.megabytes
      errors.add(:document, "Image #{document.filename} is too big")
    end
  end

  def clean_up_documents
    ActiveStorage::Blob.unattached.find_each(&:purge_later)
  end
end
