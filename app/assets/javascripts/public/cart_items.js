$(function(){
  $("#info_address_registered_address").focus(function(){
      $("#info_registered_addresses").attr("disabled", false)
  $("#info_address_registered_address").blur(function(){
      $("#info_registerd_addresses").attr("disabled", false)
    });
  });
});