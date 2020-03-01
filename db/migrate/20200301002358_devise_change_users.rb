# frozen_string_literal: true

class DeviseChangeUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :encrypted_password, :string, null: false, default: ""

    ## Recoverable
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime

    ## Rememberable
    add_column :users, :remember_created_at, :datetime

    add_index :users, :reset_password_token, unique: true
  end
end
