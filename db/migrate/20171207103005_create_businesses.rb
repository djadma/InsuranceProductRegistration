class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :rut
      t.string :company_type
      t.string :site
      t.string :logo
      t.text   :product_IDs
      t.text   :emails
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
