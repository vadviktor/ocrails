class Image < ApplicationRecord
  belongs_to :project
  acts_as_list scope: :project
  has_many :texts, dependent: :destroy

  has_one_attached :document do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]
  end

  validate :document_maximum_size
  after_validation :clean_up_documents

  scope :processed, -> { where(text_extracted: true) }
  scope :unprocessed, -> { where(text_extracted: false) }
  scope :in_order, -> { order(position: :asc) }

  private

  def document_maximum_size
    if document.blob.byte_size > 5.megabytes
      errors.add(:document, "Image #{document.filename} is too big")
    end
  end

  def clean_up_documents
    ActiveStorage::Blob.unattached.find_each(&:purge_later)
  end
end
