$(document).ready(function() {
  $('body').on('keyup', '#search_field', function(e){

    var params = $(this).serialize();
    var selfsearch = $(this);

    $.ajax({
      url: '/search',
      type: 'GET',
      data: params,
      dataType: 'json',
      success: function(response){
        if(response.status == 'success'){
            selfsearch.next().append(response.html);
          }
        }
    });
    return false;
  });
  $('body').on('keydown', '#search_field',function(e){

     $(this).next().empty();
  })

});
