class AddMoreToAddressAttributesToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :tocountry, :string
    add_column :packages, :tofirst_name, :string
    add_column :packages, :tolast_name, :string
  end
end
