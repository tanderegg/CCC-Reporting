class ReportFieldGroupsController < ApplicationController
	
	before_filter :find_report
	
	def new
		@report_field_group = ReportFieldGroup.new
	end
	
	def create
		@report_field_group = ReportFieldGroup.new(params[:report_field_group])
		
		if @report_field_group.save
			flash[:notice] = "Report group successfully created."
		else
			flash[:error] = "Failed to create report group."
		end
		redirect_to organization_report_path(@report_field_group.report.organization, @report_field_group.report)
	end
	
	def edit
		@report_field_group = ReportFieldGroup.find(params[:id])
	end
	
	private
	
	def find_report
		@report = Report.find(params[:report_id])
	end
end