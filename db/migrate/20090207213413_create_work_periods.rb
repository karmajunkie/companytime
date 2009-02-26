class CreateWorkPeriods < ActiveRecord::Migration
  def self.up
    create_table :work_periods do |t|
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :work_periods
  end
end
