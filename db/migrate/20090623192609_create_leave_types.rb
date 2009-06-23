class CreateLeaveTypes < ActiveRecord::Migration
  def self.up
    create_table :leave_types do |t|
      t.string :name
      t.integer :gl_code

      t.timestamps
    end
	  add_column :leave_requests, :leave_type_id, :integer
  end

  def self.down
	  remove_column :leave_requests, :leave_type_id
    drop_table :leave_types
  end
end
