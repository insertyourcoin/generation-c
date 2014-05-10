class CreateColorSchemes < ActiveRecord::Migration
  def change
    create_table :color_schemes do |t|
      t.string :scheme

      t.timestamps
    end
  end
end
