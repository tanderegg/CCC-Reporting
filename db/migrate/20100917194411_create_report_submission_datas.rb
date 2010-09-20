class CreateReportSubmissionDatas < ActiveRecord::Migration
  def self.up
    create_table :report_submission_datas do |t|
      t.integer :report_submission_id
      t.integer :report_field_id
      t.string :value
      t.text :text_value

      t.timestamps
    end
  end

  def self.down
    drop_table :report_submission_datas
  end
end
