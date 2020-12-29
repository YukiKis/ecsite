// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require_tree .

$(document).on("turbolinks:load", function(){
  $(window).on("resize", function(){
    if($(".container").height() <= $(window).height()){
      $(".container").height($(window).height());
    };
  });
  $(window).trigger("resize")
  
  $("input[name='info[address]']").on("change", function(){
    if($("#info_address_registered_address").prop("checked")){
      $("#info_registered_addresses").prop("disabled", false);
      $("#info_new_address_postcode").prop("disabled", true);
      $("#info_new_address_address").prop("disabled", true);
      $("#info_new_address_name").prop("disabled", true);
    }else if($("#info_address_new_address").prop("checked")){
      $("#info_registered_addresses").prop("disabled", true);
      $("#info_new_address_postcode").prop("disabled", false);
      $("#info_new_address_address").prop("disabled", false);
      $("#info_new_address_name").prop("disabled", false);
    }else{
      $("#info_registered_addresses").prop("disabled", true);
      $("#info_new_address_postcode").prop("disabled", true);
      $("#info_new_address_address").prop("disabled", true);
      $("#info_new_address_name").prop("disabled", true);
    }
  })
})
