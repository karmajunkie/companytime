class CreatePtoAllocations < ActiveRecord::Migration
  def self.up
    create_table :pto_allocations do |t|
      t.integer :timesheet_id
      t.datetime :allocation_date
      t.float :sick, :default => 0.0
      t.float :vacation, :default => 0.0
      t.float :holiday, :default => 0.0

      t.timestamps
    end
  end

  def self.down
    drop_table :pto_allocations
  end
end
