require 'open-uri'
require 'fastercsv'
namespace :timesys do
  namespace :user do
    desc "copy a user's time records over from timeclock.talho.org-- call as rake timesystem:load login=username"
    task :import=> :environment do
      login=ENV['login']
      create=ENV['create'] || false
      verbose=ENV['verbose'] || false
      pretend=ENV['pretend'] || false
      #todo: spit out error if no user found
      user=User.find_by_login(login)
      if user==nil 
        if create
          user=User.new({:login => login, :valid_user => true})
          puts "Creating user #{login}" 
          user.save
        else
          throw "user not found and create=true not specified"
        end
      end
      csv_stream=Kernel.open(emphours_uri(login))
      csv_data=csv_stream.read
      hours= FasterCSV.parse(csv_data)
      if hours
        hours.each do |row|
          begin
            m,d,y=row[1].strip.split("/")
            start=Date.new( y.to_i, m.to_i, d.to_i)
            wshift=WorkPeriod.new
            wshift.start_time=start.to_time
            wshift.end_time=(start.to_time+(3600*row[2].strip.to_f))
            puts "Adding new work_period for #{start.strftime("%x")}: #{row[2].strip} in, #{wshift.hours} saved" if verbose
            user.work_periods<<wshift unless pretend
            if user.new_record?
              user.name=row[0]
              user.save unless pretend
            end
          rescue
            
            puts "Invalid data for date=#{row[1].strip.to_s}, hours=#{row[2].strip}, skipping"
          end
        end
      end
      user.save
    end

    desc "delete a user's shift records"
    task :clear => :environment do
      login=ENV['login']
      user=User.find_by_login(login)
      user.work_periods.each do |period|
        period.destroy
      end
    end
  end
  namespace :allocations do
    desc "import allocations from a csv file (file=/path/to/file), and optionally a user (login=username), create flag (create=true) or override flag (override=true)"
    task :import => :environment do
      filename=ENV['file']
      login=ENV['login']
      override=ENV['override']
      create_flag = ENV['create']
      fileh=File.open(filename,'r')
      data=fileh.read
      allocs=FasterCSV.parse(data)
      fileh.close
      allocs.each do |row|
        if row[0]==login || login.nil?
          user=User.find_by_login(row[0])
          
          if create_flag && user.nil?
            user=User.create({:login => row[0]})
            user.save
            puts "created new user #{row[0]}"
          end
          ga=user.grants.find_by_import_code(row[1])
          if ga.nil?
            grant=Grant.find_by_import_code(row[1]) 
            if create_flag && grant.nil?
              grant= Grant.create({:import_code => row[1]})
              puts "Created new grant with import code #{grant.import_code}"
            end
            grant.save 
            ga=user.grant_allocations.build({:grant_id => grant.id, :weight => row[3]})
            if ga.save
              puts "Added grant allocation for user #{user.name} and grant #{grant.title}"
            else
              puts "there was a problem adding grant allocation for user #{user.name} and grant #{grant.title}"
            end
          else
            if override
              ga.weight=row[3]
              ga.save
              puts "User already has a grant allocation for this grant, overriding"
            else
              puts "User already has a grant allocation for this grant, override flag not supplied.  Try again with override=true."
            end
          end
        end
      end
    end
  end
end
def emphours_uri(login)
  # we didn't use timeclocks before july last year
  period_begin=Date.new 2008, 7, 1
  period_end=Date.today
  "http://timeclock.talho.org/reports/get_csv.php?rpt=hrs_wkd&display_ip=&csv=1&office=&group=&fullname=#{login}&from=#{period_begin.to_time.to_i}&to=#{period_end.to_time.to_i}&tzo=-21600&paginate=1&round=3&details=0&rpt_run_on=#{Time.now.to_i}&rpt_date=#{Date.today.strftime("%x")}&from_date=#{period_begin.strftime("%x")}"
end
