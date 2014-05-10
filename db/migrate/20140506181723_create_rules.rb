class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :turn_on
      t.string :turn_off
      t.belongs_to :user
      t.string :name
      t.string :description
      t.timestamps
    end
  end
end
