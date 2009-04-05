class TimesheetsController < ApplicationController
  def new

  end

  def edit_orig
      @period_begin = Date.new params[:period_begin]['year'].to_i, params[:period_begin]['month'].to_i, params[:period_begin]['day'].to_i
      @period_end = (@period_begin >> 1) -1
      @user = User.find_by_login(params[:user_login])
      @comp_accumulated=0
      @month_total_hours=0
      @month_expected_hours=160 #days 1-28 always have 160 work hours in them
      (@period_begin+28).upto @period_end do |d|
        @month_expected_hours+=8 if d.cwday <= 5
      end
      @hour_totals=@user.work_periods.for_month(@period_begin).total_hours.map!{ |wkday| 
        @comp_accumulated += (wkday.total_hours.to_f-8) if wkday.total_hours.to_f > 8
        @month_total_hours+=wkday.total_hours.to_f
        [wkday.total_hours.to_f, wkday.date_worked]
      }

  end

end
