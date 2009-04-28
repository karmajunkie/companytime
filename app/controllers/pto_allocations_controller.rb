class PtoAllocationsController < ApplicationController
  def update
    @pto_allocation=PtoAllocation.find(params[:id])
    if(@pto_allocation)
      @pto_allocation[params[:type]]=params[:hours]
      if(params[:type]!="comp")
        ea=@pto_allocation.timesheet.ending_accrual
        ea["#{params[:type]}_hours"]+=params[:hours].to_f
        ea.save
      end
      @pto_allocation.user_modified=true
      if @pto_allocation.save
        render :json => @pto_allocation.to_json
      else
        render :text => "Failed saving pto record", :status => 403
      end
    else
      render :text => "Could not find record", :status => 404
    end
  end

  def reset
  end

end
