class AddColumnNotificationDeliveredTrip < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :notification_delivered, :boolean, null: false
  end
end
