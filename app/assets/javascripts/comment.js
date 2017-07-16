$(document).ready(function() {
  $('body').on('submit', '.newcomment', function(e){
    e.preventDefault();
    var params = $(this).serialize();
    var self = $(this);
    $.ajax({
      url: self.attr('action'),
      type: 'POST',
      data: params,
      dataType: 'json',
      success: function(response){
        if(response.status == 'success'){
            self.prev().prev().append(response.html);
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
    var self = $(this);
    $.ajax({
      type: self.attr('data-method'),
      url: self.attr('href'),
      dataType: 'json',
      data: {},
      success: function(response) {
      if(response.status == 'success'){
        self.parent().parent().hide('slow');
      }
    }
  });
    return false;
  });

});
