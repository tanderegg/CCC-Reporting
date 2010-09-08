require "lib/exceptions.rb"
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '4219c15f74549a3c9d672356f8794cab'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  helper_method :current_user
  
  rescue_from Exceptions::SecurityTransgression, :with => lambda {head (:forbidden)}
  
  before_filter :access_control
  
  private
  
  def current_user_session
  	return @current_user_session if defined?(@current_user_session)
  	@current_user_session = UserSession.find
  end
  
  def current_user
  	return @current_user if defined?(@current_user)
  	@current_user = current_user_session && current_user_session.record
  end
  
  def access_control(permissions=[])
  	unless (current_user || (permissions.include?("ALL")))
  		raise Exceptions::SecurityTransgression
  	end
  end
  
end
