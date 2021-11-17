/*global $*/
$(document).on('turbolinks:load', function(){
  $("td[data-link]").click(function() {
    window.location = $(this).data("link")
  });
});