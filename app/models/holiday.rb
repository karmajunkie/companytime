# == Schema Information
# Schema version: 20090529235331
#
# Table name: holidays
#
#  id           :integer(4)      not null, primary key
#  holiday_date :date
#  name         :string(255)
#  optional     :boolean(1)
#  created_at   :datetime
#  updated_at   :datetime
#

class Holiday < ActiveRecord::Base
end
