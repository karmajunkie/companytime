require 'fastercsv'

FasterCSV.open(File.dirname(__FILE__) + '/leave_types.csv', :headers => true) do |leave_types|
  leave_types.each do |leave_type|
    LeaveType.seed(:name, :gl_code) do |lt|
      lt.name = leave_type['Name']
      lt.gl_code = leave_type['GL']   
    end
  end
end