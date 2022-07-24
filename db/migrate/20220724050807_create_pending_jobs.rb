class CreatePendingJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :pending_jobs do |t|
      t.string :name
      t.timestamps

      t.index :name, unique: true
    end
  end
end
