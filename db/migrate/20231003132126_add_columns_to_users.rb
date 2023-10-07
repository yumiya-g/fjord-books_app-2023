class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :postal_code, :integer
    add_column :users, :prefecture, :string
    add_column :users, :city, :string
    add_column :users, :house_number, :string
    add_column :users, :building, :string
    add_column :users, :self_introduction, :string
  end
end
