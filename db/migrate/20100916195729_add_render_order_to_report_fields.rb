class AddRenderOrderToReportFields < ActiveRecord::Migration
  def self.up
  	add_column :report_fields, :render_order, :integer
  end

  def self.down
  	drop_column :report_fields, :render_order
  end
end
