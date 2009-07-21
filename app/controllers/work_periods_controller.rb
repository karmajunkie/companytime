class WorkPeriodsController < ApplicationController
  layout "admin"
  active_scaffold :work_period do |config|
    config.actions << :field_search
    config.columns[:user].form_ui= :select
    config.columns[:user].search_sql = 'users.id'
    config.columns.exclude :created_at, :updated_at, :note
    config.search.columns << :user
    config.list.columns =   [:user, :start_time, :end_time]
    config.update.columns = [:user, :start_time, :end_time]
    config.create.columns = [:user, :start_time, :end_time]
    config.search.columns = [:user, :start_time, :end_time]
    config.field_search.columns = [:user, :start_time, :end_time]
  end
  def before_update_save(record)
    record.start_time=record.start_time.localtime if record.start_time
  end
end
