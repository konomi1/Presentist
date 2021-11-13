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
//= require_tree .

/*global $*/
/*global location $*/
$(document).on('turbolinks:load',function () {
// 前ページからのアンカーで表示タブを変更
  //アンカーを取得
  var hash = location.hash;
  hash = (hash.match(/^#tab\d+$/) || [])[0];

  //タブネームにアンカーを入れる
  if($(hash).length){
    var tabname = hash.slice(1) ;
  } else{
    var tabname = "tab1";
  }

  //何番目のタブか
  var tabno = $('.follow-tab li#' + tabname).index();

  $('.follow-tab .panel').hide();
  $('.follow-tab a').removeClass('active');
  $('.follow-tab .panel').eq(tabno).show();
  $('.follow-tab a').eq(tabno).addClass('active');

// タブクリック
  $('.follow-tab a').on('click', function(event) {
    $(".follow-tab .panel").hide();
    $(".follow-tab .active").removeClass("active");
    $(this).addClass("active");
    $($(this).attr("href")).show();
    event.preventDefault();
  });
});