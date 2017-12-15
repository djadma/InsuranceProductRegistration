class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :properties
      t.belongs_to :insurance_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
