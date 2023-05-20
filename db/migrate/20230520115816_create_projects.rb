class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :internal_id

      t.timestamps
    end
    add_index :projects, :name, unique: true
    add_index :projects, :internal_id, unique: true
  end
end
