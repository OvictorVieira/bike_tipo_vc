class AddVacanciesToStations < ActiveRecord::Migration[6.0]
  def change
    add_column :stations, :vacancies, :integer, null: false
  end
end
