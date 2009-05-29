require 'fastercsv'

FasterCSV.open(File.dirname(__FILE__) + '/holidays.csv', :headers => true) do |holidays|
  holidays.each do |holiday|
    Holiday.seed(:name, :holiday_date) do |h|
      h.name = holiday['Name']
      h.holiday_date = Date.parse(holiday['Date'])
      h.optional = holiday['Optional'].downcase == 'true'
    end
  end
end
