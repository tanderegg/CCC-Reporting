class Report < ActiveRecord::Base
  attr_accessible :name, :active, :created_by, :start_date, :end_date, :organization_id, :description
  
  belongs_to :organization
  has_many :report_field_groups
  has_many :report_submissions
  
  def creator
  	User.find(created_by) || "Unknown"
  end
end
