$(document).ready(function(){
  $('.newcomment2rd').hide();
  $('label.comments').on('click', function() {
    $(this).next().toggle();
    return false;
  });

  $('body').on('click', 'label.reply', function(event) {
    $(this).parent().next().next().toggle();
    return false;
  });

  (function() {
    var video = document.getElementById("my-video");
    if(video){
      video.addEventListener( "canplay", function() {
        video.play();
      });
    }
  })();

});
