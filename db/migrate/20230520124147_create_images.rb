# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.references :project, null: false, foreign_key: true
      t.boolean :text_extracted, null: false, default: false

      t.timestamps
    end
  end
end
