$(document).ready(function() {
 (function() {
    $('.contentpost').append(function(){
      str = $(this).text();

      str = str.replace(/\\%/gi,"%");
      $(this).empty();
      html = $.parseHTML( str );
      return html;
    });
  })();

  (function(){
     searchfield = $('#search');
     if(searchfield.val() == "\\%") searchfield.val("%");

  })();
});
