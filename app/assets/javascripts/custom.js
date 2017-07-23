$(document).ready(function() {
  (function() {
    var video = document.getElementById('my-video');
    if(video){
      video.addEventListener( 'canplay', function() {
        video.play();
      });
    }
  })();
  $('.title').on('keyup keypress', function(e) {
  var keyCode = e.keyCode || e.which;
  if (keyCode === 13) {
    e.preventDefault();
    return false;
  }
});
});
