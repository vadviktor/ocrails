# frozen_string_literal: true

class CreateTexts < ActiveRecord::Migration[7.0]
  def change
    create_table :texts do |t|
      t.references :image, null: false, foreign_key: true
      t.text :text, null: false
      t.string :svg_polygon_points, null: false

      t.timestamps
    end
  end
end
