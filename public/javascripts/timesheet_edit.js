$(function(){

    $("div.source").draggable({ revert:true});
    $("div.cal_container").droppable({
      drop:allocation_drop
      });
    $.ajaxSetup({ 
      'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")} 
    });  
    $(document).ajaxSend(function(event, request, settings) {
      if ( settings.type.toLowerCase() == 'post' ) {
          settings.data = (settings.data ? settings.data + "&" : "")
              + "authenticity_token=" + encodeURIComponent( AUTH_TOKEN );
      }
    });


})

function allocation_drop(evt, ui){
  var drag,drop,accrual_hrs,daily_hrs,type,daytype,shortage;
   drag=ui.draggable;
   drop=$(evt.target);
   accrual_hrs=parseFloat(drag.attr("hours"));
   if(!accrual_hrs) { alert("No hours in this accrual source; use another source type."); return; }
   daily_hrs=getTotalHours(drop);
   type=drag.attr("atype");
   daytype=drop.attr("day_type");
  if(daytype=="weekday" || daytype=='holiday'){
    if(daily_hrs < 8){
      //determind hour shortage
      shortage=Math.min(8-daily_hrs, accrual_hrs);
      //add to the appropriate pto allocation on drop
      drop.attr(type, parseFloat(drop.attr(type))-shortage);
      updateAccrual(type, accrual_hrs-shortage);
      updateDrop(drop);

      //ajax send update to server
      updateServer(drop, drag);

    }else{
      alert("You don't have a shortage of hours on this day.");
      return;
    }
  }else{
    alert("You can't assign extra hours to a weekend.");
    return;
  }
}

function getTotalHours(elm){
  return parseFloat(elm.attr("hours"))-
    parseFloat(elm.attr("sick_hours"))-
    parseFloat(elm.attr("holiday_hours"))-
    parseFloat(elm.attr("vacation_hours"))-
    parseFloat(elm.attr("comp_hours"));
}
function updateDrop(d){
  $(["sick_hours", "holiday_hours", "comp_hours", "vacation_hours"]).each(function(){
      $("span[type='"+this+"']", d).html(d.attr(this+"")+" "+this.toString().substr(0,1).toUpperCase())
  });
  if(getTotalHours(d) >= 8 ){
    d.removeClass("short_hrs");
    d.addClass("overtime");
  }
}
function updateAccrual(type, new_val){
  src=$("div.source[atype="+type+"]");
  src.attr("hours", new_val);
  src.html(new_val);
}
function updateServer(ptonode, sourcenode){
  atype=sourcenode.attr("atype");
  $.ajax(
  { dataType:'json',
    error:serverUpdateError,
    success:serverUpdateSuccess,
    url:"/pto_allocations/update/"+ptonode.attr("pto_id"),
    type:"get" ,
    data:{  type  : atype.substr(0, atype.length-6),
            hours : ptonode.attr(atype) }
  });
}
function serverUpdateError(data, textStatus, errorThrown){
  if(data.status == 403 || data.status == 404){
    alert(data.responseText);
  }else{
    alert("There was an error updating the server's information. Try refreshing and attempting again.");
  }
}
function serverUpdateSuccess(data, textStatus){
}
