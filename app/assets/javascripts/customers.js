$( document ).ready(function() {
  $( ".delete_address" ).click(function(){
    if(confirm("Are you sure?")){
      var customer_id = $(this).attr('customer_id');
      var address_id = $(this).attr('delivery_address_id');
      $.ajax({
        type: "delete",
        url: `/customers/${customer_id}/delivery_addresses/${address_id}`,
        dataType: 'json',
        success:function(data){
          $("#"+data.id).remove();
        }
      });
    }
    else {
      return false;
    }
  });
});
