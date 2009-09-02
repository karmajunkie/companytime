module WorkPeriodsHelper
  def end_time_column(rec)
    rec.end_time.localtime.strftime("%x %X") if !rec.end_time.nil?
  end
  def start_time_column(rec)
    rec.start_time.localtime.strftime("%x %X") 
  end
  #def start_time_form_column(rec, inputname)
    #"From: "+date_select( rec, rec.start_time, :name => (inputname + "[from]"),
                         #:include_blank => true,
                         #:default => Date.today.beginning_of_month) + " To: "+
              #date_select( rec, rec.start_time, :name => (inputname + "[to]"),
                         #:include_blank => true,
                         #:default => Date.today.end_of_month)
  #end
  #def end_time_form_column(rec, inputname)
    #"From: "+date_select( rec, rec.end_time, :name => (inputname + "[from]"), 
                         #:include_blank => true,
                         #:default => Date.today.beginning_of_month) + " To: "+
              #date_select( rec, rec.end_time, :name => (inputname + "[to]"),
                         #:include_blank => true,
                         #:default => Date.today.end_of_month) 
  #end
  #def user_search_column(record, inputname)
  #end
end

