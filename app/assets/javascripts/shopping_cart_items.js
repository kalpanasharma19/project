$( document ).ready(function() {
  $( ".change_quantity" ).click(function(){
      var action_path = $(this).attr('data_href');
      $.ajax({
        type: "POST",
        url: action_path,
        dataType: 'json',
        success:function(data){
          $("#quantity_"+data.id).text(data.quantity);
          var total_price = data.price * data.quantity;
          $("#price_"+data.id).text(total_price);
        }
      });
    });
});
