class CreateLeavePeriods < ActiveRecord::Migration
  def self.up
    create_table :leave_periods do |t|
      t.integer :leave_request_id
      t.date :from_date
      t.date :until_date
      t.time :from_time
      t.time :until_time

      t.timestamps
    end
  end

  def self.down
    drop_table :leave_periods
  end
end
