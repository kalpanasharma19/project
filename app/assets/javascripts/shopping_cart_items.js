# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

success: function(data, textStatus, xhr){
$("#<%= @shopping_cart_item.id %>").html("<%= escape_javascript(render partial: 'shopping_cart_item', locals: { item: @shopping_cart_item } ) %>");
}
