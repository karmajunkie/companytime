class TimesheetsController < ApplicationController
  def new

  end

  def edit
      @period_begin = Date.new params[:period_begin]['year'].to_i, params[:period_begin]['month'].to_i, params[:period_begin]['day'].to_i
      @period_end = (@period_begin >> 1) -1
      @user = User.find_by_login(params[:user_login])
      @comp_accumulated=0
      @month_total_hours=0
      @month_expected_hours=160 #days 1-28 always have 160 work hours in them
      (@period_begin+28).upto @period_end do |d|
        @month_expected_hours+=8 if d.cwday <= 5
      end
      @hour_totals=@user.work_periods.for_month(@period_begin).total_hours.map!{|wkday| 
        @comp_accumulated += (wkday.total_hours.to_f-8) if wkday.total_hours.to_f > 8
        @month_total_hours+=wkday.total_hours.to_f
        [wkday.total_hours.to_f, wkday.date_worked]
      }

  end

  def generate
    if request.post?
      period_begin = Date.new params[:period_begin]['year'].to_i, params[:period_begin]['month'].to_i, params[:period_begin]['day'].to_i
      period_end = (period_begin >> 1) -1
      csv_uri=emphours_uri(params[:user_login], period_begin)
      csv_data=get_hours_csv(csv_uri)
      begin
        csv_data=FasterCSV.parse(csv_data)
      rescue FasterCSV::MalformedCSVError => e
        #do something here, display an error message or something useful
        redirect_to :new
      end
      user=User.find_by_login(params[:user_login])

      time_xls=Spreadsheet.open TIMESHEET_TEMPLATE_XLS
      timesheet=time_xls.worksheet(0)

      #update the identifying info
      first_name, last_name=user.name.split(" ")
      timesheet.row(3)[0]=first_name
      timesheet.row(3)[2]=last_name
      timesheet.row(6)[0]=period_begin.strftime("%B")
      timesheet.row(6)[2]=period_begin.strftime("%Y")

      period_begin.upto period_end do |day_of_mth|
        timesheet.row(10)[2 + day_of_mth.day]=day_of_mth.day
      end
      csv_data.each do |hours|
        begin
          timesheet.row(12)[2+Date.strptime(hours[1].strip, "%x").day]=hours[3]
        rescue ArgumentError => e
          #debugger
        end
      end

      {
       "unrestricted" => "Unrestricted",
       "ut_as" => "UT-AS",
       "ut_ss" => "UT-SS",
       "ut_gb" => "UT-GB",
       "han" => "HAN" 
      }.each do |gid, gname|
        timesheet.insert_row(10)
        timesheet.row(10)[0]=gname
        period_begin.upto period_end do |day_of_mth|
          timesheet.row(10)[2+day_of_mth.day] = 
            HOURS_IN_WORKDAY * user.allocation[gid] if day_of_mth.cwday < 6
        end
      end

      write_timesheet_to_personal_storage(user, time_xls)
    else
      headers["Allow"] = "POST"
      render :action => "new", :status => 405
    end
  end

  private
    def emphours_uri(login, period_begin)
      period_end=(period_begin>>1)-1
      "http://timeclock.talho.org/reports/get_csv.php?rpt=hrs_wkd&display_ip=&csv=1&office=&group=&fullname=#{login}&from=#{period_begin.to_time.to_i}&to=#{period_end.to_time.to_i}&tzo=-21600&paginate=1&round=3&details=0&rpt_run_on=#{Time.now.to_i}&rpt_date=#{Date.today.strftime("%x")}&from_date=#{period_begin.strftime("%x")}"
    end
    def get_hours_csv(csv_uri)
      csv_data=Kernel.open(csv_uri)
    end
    def write_timesheet_to_personal_storage(user,timesheet)
      storage_dir=File.join(File.dirname(TIMESHEET_TEMPLATE_XLS, user.login))
      Dir.mkdir(storage_dir) unless Dir.exists?(storage_dir)
    end

    def autoassign_pto
    end

end
