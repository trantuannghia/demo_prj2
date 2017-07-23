$(document).ready(function() {
  $('body').on('submit', '.newcomment', function(e){
    e.preventDefault();
    var params = $(this).serialize();
    var selfcmt = $(this);
    $.ajax({
      url: selfcmt.attr('action'),
      type: 'POST',
      data: params,
      dataType: 'json',
      success: function(response){
        if(response.status == 'success'){
            selfcmt.prev().prev().append(response.html);
          }
          $('textarea').val('');
          $('.newcomment2rd').hide();
        }
    });
    return false;
  });

  $('body').on('submit','.newcomment2rd', function(e){
    e.preventDefault();
    var params = $(this).serialize();
    var selfcmt = $(this);
    $.ajax({
      url: selfcmt.attr('action'),
      type: 'POST',
      data: params,
      dataType: 'json',
      success: function(response){
        if(response.status == 'success'){
            selfcmt.prev().append(response.html);
          }
          $('textarea').val('');
          $('.newcomment2rd').hide();
        }
    });
    return false;
  });

  $('body').on('click', '.delete', function(event) {
    event.preventDefault();
    var selfdel = $(this);
    $.ajax({
      type: selfdel.attr('data-method'),
      url: selfdel.attr('href'),
      dataType: 'json',
      data: {},
      success: function(response) {
      if(response.status == 'success'){
        selfdel.parent().parent().hide('slow');
      }
    }
  });
    return false;
  });

  $('body').on('click', '.editcomment_btn', function(event) {
    event.preventDefault();
    var selfbtn = $(this);
    $.ajax({
      type: selfbtn.attr('data-method'),
      url: selfbtn.attr('href'),
      dataType: 'json',
      data: {},
      success: function(response) {
      if(response.status == 'success'){
        text_edit = selfbtn.parent().prev().children('span');
        text_edit.empty();
        text_edit.append(response.html);
      }
    }
  });
    return false;
  });


  $('body').on('submit', '.edit_comment', function(event) {
    event.preventDefault();
    var selfbtn = $(this);
    var params = $(this).serialize();
    $.ajax({
      type: 'PATCH',
      url: selfbtn.attr('action'),
      dataType: 'json',
       data: params,
      success: function(response) {
      if(response.status == 'success'){
        text = selfbtn.children('#comment_content').val();
        selfbtn.parent().append(text);
        selfbtn.remove();
      }
    }
  });
    return false;
  });

});
