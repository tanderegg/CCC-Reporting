class ReportFieldGroup < ActiveRecord::Base
	belongs_to :report
	has_many :report_fields
	
	attr_accessor :previous_order
	
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
	
	private
	
	def correct_order_structure
		
		@previous_order = 10000 unless @previous_order
		
		# Update all field_groups before the new order position to be current_order+1
		if render_order > @previous_order
			self.connection.execute("UPDATE report_field_groups SET render_order=render_order-1 WHERE report_id=#{report_id} AND ((render_order < #{render_order} AND  render_order > #{@previous_order}) OR (render_order = #{render_order} AND id != #{id}))")
		elsif render_order < @previous_order
			self.connection.execute("UPDATE report_field_groups SET render_order=render_order+1 WHERE report_id=#{report_id} AND ((render_order > #{render_order} AND  render_order < #{@previous_order}) OR (render_order = #{render_order} AND id != #{id}))")
		end		
	end
end
