class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.integer :x
      t.integer :y

      t.belongs_to :grid
      t.timestamps
    end
  end
end
