class AddCompToPtoAllocations < ActiveRecord::Migration
  def self.up
    add_column :pto_allocations, :comp, :float
  end

  def self.down
    remove_column :pto_allocations, :comp
  end
end
