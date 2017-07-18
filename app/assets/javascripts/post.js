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

      }
    }
  });
    return false;
  });
