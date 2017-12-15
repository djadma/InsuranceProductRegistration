class CreateInsuranceFields < ActiveRecord::Migration
  def change
    create_table :insurance_fields do |t|
      t.string :name
      t.string :field_type
      t.boolean :required
      t.belongs_to :insurance_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
