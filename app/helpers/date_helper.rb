#
# Distributed with Rails Date Kit
# http://www.methods.co.nz/rails_date_kit/rails_date_kit.html
#
# Author:  Stuart Rackham <srackham@methods.co.nz>
# License: This source code is released under the MIT license.
#
module DateHelper

  # Rails text_field helper plus drop-down calendar control for date input. Same
  # options as text_field plus optional :format option which accepts
  # same date display format specifiers as calendar_open() (%d, %e, %m, %b, %B, %y, %Y).
  # If the :format option is not set the the global Rails :default date format
  # is used or failing that  '%d %b %Y'.
  #
  # Explicitly pass it the date value to ensure it is formatted with desired format.
  # Example:
  #
  # <%= date_field('person', 'birthday', :value => @person.birthday) %>
  #
  def date_field(object_name, method, options={})
    format = options.delete(:format) ||
             ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[:default] ||
             '%d %b %Y'
    if options[:value].is_a?(Date)
      options[:value] = options[:value].strftime(format)
    end

    text_field object_name, method, options
  end

end
