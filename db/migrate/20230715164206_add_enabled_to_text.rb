# frozen_string_literal: true

class AddEnabledToText < ActiveRecord::Migration[7.0]
  def change
    add_column :texts, :enabled, :boolean, null: false, default: true
  end
end
