class AddAcountIdToTables < ActiveRecord::Migration
  def change
  	add_column :products, :account_id, :integer
  	add_column :businesses, :account_id, :integer
  	add_column :insurance_types, :account_id, :integer
  	add_column :users, :account_id, :integer
  end
end
