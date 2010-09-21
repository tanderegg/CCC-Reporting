class ReportSubmissionsController < ApplicationController	
	
	def index
		@organizations = current_user.organization.all_children+[current_user.organization]
		@current_organization = current_user.organization
		@report = params[:selected_report] ? Report.find(params[:selected_report]) : @current_organization.reports.find(:all, :order => 'created_at ASC').first
		if @report
			@report_submissions = current_user.report_submissions.find(:all, :conditions => {:report_id => @report.id}, :order => 'submission_date DESC')
		end
	end
	
	def show
		@organizations_reports = current_user.organization.reports.find(:all,  :order => "created_at ASC")
		@report = params[:selected_report] ? Report.find(params[:selected_report]) : @organizations_reports.first
		if params[:date]
			new_date = params[:date][:month]+"-"+params[:date][:day]+"-"+params[:date][:year]
		end
		@current_date = new_date ? Date.strptime(new_date, '%m-%d-%Y') : Date.today
		
		@report_submission = ReportSubmission.find(params[:id])
	end
	
	def new
		if params[:date]
			new_date = params[:date][:month]+"-"+params[:date][:day]+"-"+params[:date][:year]
		end
		@current_date = new_date ? Date.strptime(new_date, '%m-%d-%Y') : Date.today
			
		# Determine the report and the date
		@organizations_reports = current_user.organization.reports.find(:all,  :order => "created_at ASC")
		@report = params[:selected_report] ? Report.find(params[:selected_report]) : @organizations_reports.first
		if @report			
			# See if the report has already been submitted
			@report_submission = ReportSubmission.find(:first, :conditions => {:report_id => @report.id, :user_id => current_user.id, :submission_date => @current_date})
			if @report_submission
				redirect_to report_submission_path(@report_submission, :date => params[:date], :selected_report => params[:selected_report])
			else
				@report_submission = ReportSubmission.new
			end
		end
	end
	
	def create
		@report_submission = ReportSubmission.new(:report_id => params[:report_id], :user_id => current_user.id, :submission_date => params[:date])
		
		if @report_submission.save
			if params[:report_submission]
				params[:report_submission].each_pair do |key, value|
					report_field_id = key.split("_")[1]
					
					# Check if the reserved field for text is needed, otherwise store as a string
					field_type = ReportField.find(report_field_id).report_field_type
					case field_type
					when "Number"
						regular_value = (value.blank? ? 0 : value)
						text_value = nil
					when "Text Field"
						regular_value = (value.blank? ? "N/A" : value)
						text_value = nil
					when "Text Area"
						regular_value = (value.blank? ? "N" : "Y")
						text_value = value
					end
					
					report_submission_data = @report_submission.report_submission_datas.create( :report_submission_id => @report_submission.id, 
																																										  :report_field_id => report_field_id,
																																										  :value => regular_value,
																																										  :text_value => text_value)
					report_submission_data.save
				end
			end
		
			redirect_to report_submissions_path
		else
			render :action => 'new'
		end
	end
	
	def getReports
		@reports = Organization.find(params[:organization_id]).reports
		render :action => 'getReports', :layout => false
	end
	
	def getReportHistory
		@report = Report.find(params[:report_id]) unless params[:report_id].blank?
		if @report
			@report_submissions = current_user.report_submissions.find(:all, :conditions => {:report_id => @report.id}, :order => 'submission_date DESC')
		end
		render :partial => 'report_submissions'
	end
end