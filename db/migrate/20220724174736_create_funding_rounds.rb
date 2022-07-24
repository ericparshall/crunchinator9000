class CreateFundingRounds < ActiveRecord::Migration[7.0]
  def change
    create_table :funding_rounds do |t|
      t.references :company
      t.string :funding_round_type
      t.date :funded_date
      t.integer :funded_usd
      t.timestamps
    end
  end
end
