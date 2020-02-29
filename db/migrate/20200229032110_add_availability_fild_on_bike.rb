class AddAvailabilityFildOnBike < ActiveRecord::Migration[6.0]
  def change
    add_column :bikes, :available, :boolean, null: false, index: true
  end
end
