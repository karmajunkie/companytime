class WorkPeriodsController < ApplicationController
  layout "admin"
  active_scaffold :work_period do |config|
    config.columns[:user].ui_type = :select
    config.columns[:user].search_sql = 'users.id'
    config.columns.exclude :created_at, :updated_at, :note
    config.search.columns << :user
    config.actions << :field_search
  end
end
