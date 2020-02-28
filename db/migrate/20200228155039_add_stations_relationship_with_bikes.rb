class AddStationsRelationshipWithBikes < ActiveRecord::Migration[6.0]
  def change
    add_reference :bikes, :station, foreign_key: true, null: false, index: true
  end
end
