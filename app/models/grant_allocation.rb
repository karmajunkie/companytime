# == Schema Information
# Schema version: 20090529235331
#
# Table name: grant_allocations
#
#  id         :integer(4)      not null, primary key
#  grant_id   :integer(4)
#  user_id    :integer(4)
#  weight     :float           default(0.0)
#  created_at :datetime
#  updated_at :datetime
#

class GrantAllocation < ActiveRecord::Base
  belongs_to :grant
  belongs_to :user
end
