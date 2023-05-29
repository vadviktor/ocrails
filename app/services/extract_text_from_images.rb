# require 'aws-sdk-textract'

class ExtractTextFromImages
  def initialize(project_id)
    p = Project.find(project_id)
    p.images
    @active_storage_attachment = active_storage_attachment
  end

  def run
    image.analyze unless image.analyzed?
    lines = detected_text.blocks.select { |b| b.block_type == "LINE" }

    lines.each do |line|
      polygon_points = line.geometry.polygon.map { |p| [p.x, p.y] }
      svg_coordinates = polygon_points.map do |p|
        [
          (p[0] * image.blob.metadata["width"]).round,
          (p[1] * image.blob.metadata["height"]).round
        ].join(",")
      end.join(" ")

      Text.create!(text: line.text, svg_polygon_points: svg_coordinates, project_id: image.record_id)
    end
  end

  private

  def detected_text
    textract_client.detect_document_text(
      {
        document: {
          s3_obejct: {
            bucket: Rails.application.credentials.dig(:aws, :bucket),
            name: image.blob.key
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
