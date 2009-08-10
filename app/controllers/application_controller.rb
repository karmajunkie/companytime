# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Clearance::Authentication
  helper :all # include all helpers, all the time  

  before_filter :login_required
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '8d1e4319f25c223f9c763263607102d0'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  require 'open-uri'
#  before_filter :login_required
  protected
      def login_required
        store_location
        unless signed_in?
          redirect_to sign_in_path
          false
        end
	      true
      end

      def admin_required
        unless current_user.admin? 
          flash[:notice] = "That resource does not exist or you do not have access to it"
          redirect_to root_path
          false
        end
      end

			def admin_or_self_required
				unless current_user.admin? || params[:id] == current_user.id.to_s
					flash[:notice] = "You are not authorized to view this resource.  You must be an admin or a user with permission to view the requested page."
					redirect_to root_path
					false
				end
			end
	
end
