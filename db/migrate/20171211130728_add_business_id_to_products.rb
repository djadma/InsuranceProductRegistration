class AddBusinessIdToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :business_id, :integer
  end
end
