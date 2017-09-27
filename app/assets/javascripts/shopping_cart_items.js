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

  $( ".destroy_item" ).click(function(){
   if(confirm("Are you sure?")){
      var customer_id = $(this).attr('customer_id');
      var item_id = $(this).attr('item_id');
      $.ajax({
        type: "delete",
        url: `/customers/${customer_id}/shopping_cart_items/${item_id}`,
        dataType: 'json',
        success:function(data){
          $("#"+item_id).remove();
          if (data == 0) {
            $(".cart").children().last().remove();
            $(".cart").text("Your cart is empty!");
          }
        }
      });
    }
    else {
      return false;
    }
  });
});
