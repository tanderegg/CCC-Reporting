class CreateReportFieldGroups < ActiveRecord::Migration
  def self.up
    create_table :report_field_groups do |t|
      t.string :title
      t.string :pos_x
      t.string :pos_y
      t.string :width
      t.string :height
      t.string :float
      t.integer :render_order
      t.integer :created_by
      t.integer :updated_by
      t.integer :report_id

      t.timestamps
    end
  end

  def self.down
    drop_table :report_field_groups
  end
end
