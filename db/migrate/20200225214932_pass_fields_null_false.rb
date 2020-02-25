class PassFieldsNullFalse < ActiveRecord::Migration[6.0]
  def change
    change_column :bikes, :code, :string, null: false
    change_column :users, :name, :string, null: false
    change_column :stations, :name, :string, null: false
  end
end
