$(document).ready(function(){
  $('body').on('click', '#editbutton', function(e){

    e.preventDefault();
    var params = $(this).serialize();
    var editcmt = $(this);
    $.ajax({
      url: editcmt.attr('href'),
      type: 'GET',
      data: params,
      dataType: 'json',
      success: function(response){
        if(response.status == 'success'){
            editcmt.parent().prev().append(response.html);
            var a = editcmt.parent().prev().find('#post_content');
            a.text(a.text().replace(/<br>/g, "\r\n"));
          }
        }
    });
    return false;
  });

  $('body').on('click', '#button_cancle', function(e){
    $(this).parent().parent().remove();
  });
});
