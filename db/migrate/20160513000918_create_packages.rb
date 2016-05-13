class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :country

      t.timestamps null: false
    end
  end
end
