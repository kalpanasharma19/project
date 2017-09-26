$( document ).ready(function() {
$( ".add_to_cart" ).click(function(){
      var product_id = $(this).attr('product_id');
      $.ajax({
        type: "POST",
        data: { product_id },
        url:  '/shopping_cart_items',
        dataType: 'json',
        success:function(data){
          alert("product added to cart!");
        }
      });
    });
});
