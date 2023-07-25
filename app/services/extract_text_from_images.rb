# frozen_string_literal: true

require 'aws-sdk-textract'

class ExtractTextFromImages
  def initialize(project_id)
    @project = Project.find(project_id)
  end

  def run
    @project.images.unprocessed.each do |image|
      image.document.analyze unless image.document.analyzed?
      lines = detected_text(image.document).blocks.select { |b| b.block_type == 'LINE' }
      save_text_data(lines, image)
      image.update!(text_extracted: true)
    end
  end

  private

  def save_text_data(lines, image)
    lines.each do |line|
      polygon_points = line.geometry.polygon.map { |p| [p.x, p.y] }
      svg_coordinates = polygon_points.map do |p|
        [
          (p[0] * image.document.blob.metadata['width']).round,
          (p[1] * image.document.blob.metadata['height']).round
        ].join(',')
      end.join(' ')

      image.texts.create!(text: line.text, svg_polygon_points: svg_coordinates)
    end
  end

  def detected_text(document)
    textract_client.detect_document_text(
      {
        document: {
          s3_object: {
            bucket: "#{Rails.application.credentials.dig(:aws, :bucket)}-#{Rails.env}",
            name: document.blob.key
          }
        }
      }
    )
  end

  def textract_client
    @_textract_client ||= Aws::Textract::Client.new(
      region: Rails.application.credentials.dig(:aws, :region),
      credentials: Aws::Credentials.new(
        Rails.application.credentials.dig(:aws, :access_key_id),
        Rails.application.credentials.dig(:aws, :secret_access_key)
      )
    )
  end
end
