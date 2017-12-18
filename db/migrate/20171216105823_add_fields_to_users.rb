class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :mother_lname, :string 
  	add_column :users, :common, :string
  	add_column :users, :region, :string
  	add_column :users, :number, :string
  	add_column :users, :parent_id, :integer
  end
end
