class AddColumnsToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :first_name, :string
    add_column :packages, :last_name, :string
  end
end
