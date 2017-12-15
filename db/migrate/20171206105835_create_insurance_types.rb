class CreateInsuranceTypes < ActiveRecord::Migration
  def change
    create_table :insurance_types do |t|
      t.string :name
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
