class RefactorImages < ActiveRecord::Migration[7.0]
  def change
    remove_reference :texts, :image, null: false, foreign_key: true
    drop_table :images
    add_reference :texts, :project, null: false, foreign_key: true
  end
end
