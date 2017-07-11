$(document).ready(function() {
  (function() {
    var video = document.getElementById('my-video');
    if(video){
      video.addEventListener( 'canplay', function() {
        video.play();
      });
    }
  })();
});
