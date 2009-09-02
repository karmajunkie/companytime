class WorkPeriodsController < ApplicationController
  layout "admin"
  active_scaffold :work_period do |config|
    config.actions << :field_search
    config.columns[:user].form_ui= :select
    config.columns[:user].search_sql = 'users.id'
    config.columns[:start_time].options = {:discard_time => true, :begin_date => Date.today.beginning_of_month, :end_date => Date.today.end_of_month }
    config.columns.exclude :created_at, :updated_at, :note
    config.search.columns << :user
    config.list.columns =   [:user, :start_time, :end_time]
    config.update.columns = [:user, :start_time, :end_time]
    config.create.columns = [:user, :start_time, :end_time]
    config.search.columns = [:user, :start_time, :end_time]
    config.field_search.columns = [:user, :start_time]
  end
  def before_update_save(record)
    record.start_time=record.start_time.localtime if record.start_time
  end
#	helper :date
#
#	def search
#		@search_params=WorkPeriodSearchParameters.new(params[:work_period_search_parameters])
#		@search_params.user=current_user unless current_user.admin?
#		@work_periods = WorkPeriod.for_employee(@search_params.user).starts_after(@search_params.start_date).starts_before(@search_params.end_date)
#	end
end
