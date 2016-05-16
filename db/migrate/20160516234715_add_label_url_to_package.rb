class AddLabelUrlToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :label_url, :string
  end
end
