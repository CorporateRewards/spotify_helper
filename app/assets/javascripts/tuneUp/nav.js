$(document).ready(function() {

  var active1 = false;
  var active2 = false;
  var active3 = false;
  var active4 = false;

    $('.parent2').on('click', function() {
    
    if (!active1) $(this).find('.test1').css({'background-color': 'orange', 'transform': 'translate(0px,120px)'});
    else $(this).find('.test1').css({'background-color': 'white', 'transform': 'none'}); 
     if (!active2) $(this).find('.test2').css({'background-color': 'orange', 'transform': 'translate(0px,220px)'});
    else $(this).find('.test2').css({'background-color': 'white', 'transform': 'none'});
      if (!active3) $(this).find('.test3').css({'background-color': 'orange', 'transform': 'translate(0px,320px)'});
    else $(this).find('.test3').css({'background-color': 'white', 'transform': 'none'});
      if (!active4) $(this).find('.test4').css({'background-color': 'orange', 'transform': 'translate(0px,420px)'});
    else $(this).find('.test4').css({'background-color': 'white', 'transform': 'none'});
    active1 = !active1;
    active2 = !active2;
    active3 = !active3;
    active4 = !active4;
      
    });
});