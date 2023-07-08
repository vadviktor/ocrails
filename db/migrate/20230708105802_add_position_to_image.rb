class AddPositionToImage < ActiveRecord::Migration[7.0]
  def change
    add_column :images, :position, :integer
  end
end
