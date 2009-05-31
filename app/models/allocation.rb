# == Schema Information
# Schema version: 20090529235331
#
# Table name: allocations
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  han          :float
#  ut_gb        :float
#  ut_ss        :float
#  ut_as        :float
#  unrestricted :float
#  created_at   :datetime
#  updated_at   :datetime
#

class Allocation < ActiveRecord::Base
  belongs_to :user
end
