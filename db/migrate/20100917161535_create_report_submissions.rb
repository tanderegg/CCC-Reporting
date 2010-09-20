class CreateReportSubmissions < ActiveRecord::Migration
  def self.up
    create_table :report_submissions do |t|
      t.integer :report_id
      t.integer :user_id
      t.integer :submission_type_id
      t.date :submission_date
      t.text :notes
      t.boolean :approved

      t.timestamps
    end
  end

  def self.down
    drop_table :report_submissions
  end
end
