class CreateAllocations < ActiveRecord::Migration
  def self.up
    create_table :allocations do |t|
      t.integer :user_id
      t.float :han
      t.float :ut_gb
      t.float :ut_ss
      t.float :ut_as
      t.float :unrestricted

      t.timestamps
    end
  end

  def self.down
    drop_table :allocations
  end
end
