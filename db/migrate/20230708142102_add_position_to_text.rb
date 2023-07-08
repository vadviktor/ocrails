class AddPositionToText < ActiveRecord::Migration[7.0]
  def change
    add_column :texts, :position, :integer
  end
end
