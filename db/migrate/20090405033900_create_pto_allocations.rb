class CreatePtoAllocations < ActiveRecord::Migration
  def self.up
    create_table :pto_allocations do |t|
      t.integer :timesheet_id
      t.datetime :allocation_date
      t.float :sick
      t.float :vacation
      t.float :holiday

      t.timestamps
    end
  end

  def self.down
    drop_table :pto_allocations
  end
end
