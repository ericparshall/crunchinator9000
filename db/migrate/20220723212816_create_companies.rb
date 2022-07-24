class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :permalink
      t.references :company_category
      t.string :status
      t.boolean :fully_initialized, default: false

      t.timestamps
    end
  end
end
