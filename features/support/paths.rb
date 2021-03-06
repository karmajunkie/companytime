module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name, options={})
    case page_name
			when /the homepage/
				'/'
			when /the new leave_requests? page/i
				new_leave_request_path

			when /the employee portal page/i
				user_path(current_user)

			when /the admin page/i
		    admin_path
	    when /the work period search page/i
	      search_work_periods_path
	    when /the edit user page/i
		    unless options[:user].blank?
		      edit_user_path(options[:user])
		    else
			    edit_user_path(current_user)
		    end
	    when /the user profile page/i
		    unless options[:user].blank?
			    user_path(options[:user])
		    else
			    user_path(current_user)
		    end
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
