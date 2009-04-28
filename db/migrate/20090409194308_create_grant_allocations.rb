class CreateGrantAllocations < ActiveRecord::Migration
  def self.up
    create_table :grant_allocations do |t|
      t.integer :grant_id
      t.integer :user_id
      t.float :weight, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :grant_allocations
  end
end
