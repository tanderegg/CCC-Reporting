class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string :name
      t.boolean :active
      t.integer :created_by
      t.date :start_date
      t.date :end_date
      t.integer :organization_id
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :reports
  end
end
