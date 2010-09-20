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
	
	def update
		@report_field_group = ReportFieldGroup.find(params[:id])
		@report_field_group.previous_order = @report_field_group.render_order
		
		if @report_field_group.update_attributes(params[:report_field_group])
			flash[:notice] = "Report group successfully saved."
		else
			flash[:error] = "Failed to save updates to report group."
		end
		redirect_to edit_organization_report_path(@report_field_group.report.organization, @report_field_group.report)
	end
	
	private
	
	def find_report
		@report = Report.find(params[:report_id])
	end
	
end