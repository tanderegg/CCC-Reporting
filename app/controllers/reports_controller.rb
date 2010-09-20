class ReportsController < ApplicationController
	
  before_filter :find_organization
	
  def index
    @reports = @organization.reports.all
  end
  
  def show
    @report = Report.find(params[:id])
  end
  
  def new
    @report = Report.new
  end
  
  def create
    @report = Report.new(params[:report])
    if @report.save
      flash[:notice] = "Successfully created report."
      redirect_to organization_report_url(@organization, @report)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @report = Report.find(params[:id])
  end
  
  def update
    @report = Report.find(params[:id])
    if @report.update_attributes(params[:report])
      flash[:notice] = "Successfully updated report."
      redirect_to organization_report_path(@organization, @report)
    else
      render :action => 'edit'
    end
  end
  
  private
  
  def find_organization
  	@organization = Organization.find(params[:organization_id]) 
  end
end
