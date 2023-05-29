class ExtractTextFromImagesJob < ApplicationJob
  queue_as :default

  # @param project_id [Integer] Project model id
  def perform(project_id)
    ExtractTextFromImages.new(project_id).run
  end
end
