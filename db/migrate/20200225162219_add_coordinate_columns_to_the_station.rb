class AddCoordinateColumnsToTheStation < ActiveRecord::Migration[6.0]
  def change
    add_column :stations, :latitude,
               :decimal, precision: 10, scale: 6, null: false

    add_column :stations, :longitude,
               :decimal, precision: 10, scale: 6, null: false
  end
end
