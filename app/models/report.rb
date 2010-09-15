class Report < ActiveRecord::Base
  attr_accessible :name, :active, :created_by, :start_date, :end_date, :organization_id, :description
  
  belongs_to :organization
  has_many :report_field_groups
  
  def creator
  	User.find(created_by) || "Unknown"
  end
  
  def render_report
  	output = ""
  	if report_field_groups.blank?
  		output = "<em>No Report Items Exist</em>"
  	else
  		report_field_groups.find(:all, :order => 'render_order DESC').each do |g|
  			output +=  g.render_group
  		end
  	end
  	output
  end
end
