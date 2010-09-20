class ReportSubmission < ActiveRecord::Base
	belongs_to :report
	belongs_to :user
	has_many :report_submission_datas
end
