class AddAddressFromToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :company, :string
    add_column :packages, :street, :string
    add_column :packages, :street2, :string
    add_column :packages, :city, :string
    add_column :packages, :state, :string
    add_column :packages, :zip, :string
    add_column :packages, :phone, :integer, :limit => 10
    add_column :packages, :email, :string
  end
end
