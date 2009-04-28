class GrantAllocation < ActiveRecord::Base
  belongs_to :grant
  belongs_to :user
end
