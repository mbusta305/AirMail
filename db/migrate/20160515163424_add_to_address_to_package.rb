class AddToAddressToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :tocompany, :string
    add_column :packages, :tostreet, :string
    add_column :packages, :tostreet2, :string
    add_column :packages, :tocity, :string
    add_column :packages, :tostate, :string
    add_column :packages, :tozip, :string
    add_column :packages, :tophone, :integer, :limit => 10
    add_column :packages, :toemail, :string
  end
end
