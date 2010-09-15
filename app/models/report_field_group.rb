class ReportFieldGroup < ActiveRecord::Base
	belongs_to :report
	
	def render_group
		style = ""
		
		style += "float: #{float}; " unless float.blank?
		style += "width: #{width}; " unless width.blank?
		style += "height: #{height}; " unless height.blank?
		
		unless (pos_x.blank? && pos_y.blank?)
			style += "position: absolute; "
			style += "top: #{pos_y}" unless pos_y.blank?
			style += "left: #{pos_x}" unless pos_x.blank?
		end
		
		output = "<fieldset style=\"#{style}\"><legend>#{title}</legend>"
		
		output += "<em>No fields in group</em>"
		
		output += "</fieldset>"
	end
end
