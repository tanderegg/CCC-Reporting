class ReportFieldsController < ApplicationController
	
	before_filter :find_report_field_group
	
	def new
		@report_field = ReportField.new
	end
	
	def create
		@report_field = ReportField.new(params[:report_field])
		
		if @report_field.save
			flash[:notice] = "Report field successfully created!"
			redirect_to edit_organization_report_path(@report_field_group.report.organization, @report_field_group.report)		
		else
			render :action => "new"
		end
	end
	
	def edit
		@report_field = ReportField.find(params[:id])
	end
	
	def update
		@report_field = ReportField.find(params[:id])
		@report_field.previous_order = @report_field.render_order
		
		if @report_field.update_attributes(params[:report_field])
			flash[:notice] = "Report field successfully saved."
			redirect_to edit_organization_report_path(@report_field_group.report.organization, @report_field_group.report)		
		else
			render :action => 'edit'
		end
	end
	
	private
	
	def find_report_field_group
		@report_field_group = ReportFieldGroup.find(params[:report_field_group_id])
	end
end