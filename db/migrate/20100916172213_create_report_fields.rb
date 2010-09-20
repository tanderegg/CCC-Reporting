class CreateReportFields < ActiveRecord::Migration
  def self.up
    create_table :report_fields do |t|
      t.string :label
      t.integer :size
      t.string :pos_x
      t.string :pos_y
      t.string :width
      t.string :height
      t.integer :report_field_group_id
      t.integer :report_field_type_id
      t.integer :report_master_field_id
      t.string :formula
      t.string :float
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end

  def self.down
    drop_table :report_fields
  end
end
