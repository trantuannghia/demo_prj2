$(document).ready(function() {
 (function() {
    $('.contentpost').append(function(){
      str = $(this).text();
      $(this).empty();
      html = $.parseHTML( str );
      return html;
    });
  })();
});
