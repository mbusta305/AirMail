class AddShippingToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :shipping, :float
  end
end
