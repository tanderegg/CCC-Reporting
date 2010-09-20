class ReportField < ActiveRecord::Base
	belongs_to :report_field_group
	
	validates_each :label do |record, attr, value|
		record.errors.add attr, "contains illegal character '_'" if value.include? "_"
	end
	
	attr_accessor :previous_order
	
	REPORT_TYPE = [["Text Field", 0], ["Text Area", 1], ["Select Box", 2], ["Range", 3]]
	
	after_save :correct_order_structure
	
	def generate_style
		style = ""
		
		style += "float: #{float}; " unless float.blank?
		style += "width: #{width}; " unless width.blank?
		style += "height: #{height}; " unless height.blank?
		
		unless (pos_x.blank? && pos_y.blank?)
			style += "position: absolute; "
			style += "top: #{pos_y}" unless pos_y.blank?
			style += "left: #{pos_x}" unless pos_x.blank?
		end
		
		return	style
	end
	
	def report_field_type
		return REPORT_TYPE[report_field_type_id][0] if report_field_type_id
		return "Text Field"
	end
	
	private
	
	def correct_order_structure
		
		@previous_order = 100000 unless @previous_order
		
		# Update all field_groups before the new order position to be current_order+1
		if render_order > @previous_order
			self.connection.execute("UPDATE report_fields SET render_order=render_order-1 WHERE report_field_group_id=#{report_field_group_id} AND ((render_order < #{render_order} AND  render_order > #{@previous_order}) OR (render_order = #{render_order} AND id != #{id}))")
		elsif render_order < @previous_order
			self.connection.execute("UPDATE report_fields SET render_order=render_order+1 WHERE report_field_group_id=#{report_field_group_id} AND ((render_order > #{render_order} AND  render_order < #{@previous_order}) OR (render_order = #{render_order} AND id != #{id}))")
		end		
	end
end
