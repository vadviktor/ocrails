class AddEnabledToText < ActiveRecord::Migration[7.0]
  def change
    add_column :texts, :enabled, :boolean, default: true
  end
end
