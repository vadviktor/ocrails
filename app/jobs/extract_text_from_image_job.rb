class ExtractTextFromImageJob < ApplicationJob
  queue_as :default

  # @param attachment_id [Integer] Image model id
  def perform(attachment_id)
    image = ActiveStorage::Attachment.find(attachment_id)
    ExtractTextFromImage.new(image).run
  end
end
