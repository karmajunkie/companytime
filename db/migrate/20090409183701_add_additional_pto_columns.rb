class AddAdditionalPtoColumns < ActiveRecord::Migration
  def self.up
      add_column :pto_allocations, :military,      :float, :default => 0
      add_column :pto_allocations, :bereavement,   :float, :default => 0
      add_column :pto_allocations, :jury_duty,     :float, :default => 0
      add_column :pto_allocations, :unpaid_leave,  :float, :default => 0
      add_column :pto_allocations, :administrative,:float, :default => 0
  end

  def self.down
      remove_column :pto_allocations, :administrative
      remove_column :pto_allocations, :unpaid_leave
      remove_column :pto_allocations, :jury_duty
      remove_column :pto_allocations, :bereavement
      remove_column :pto_allocations, :military
  end
end
