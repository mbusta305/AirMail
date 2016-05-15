class AddPackageIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :packages_id, :integer
  end
end
