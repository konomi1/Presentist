
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
  $('#tab-menu a').on('click', function(event) {
    $('.follow-tab .panel').hide();
    $('.follow-tab .active').removeClass('active');
    $(this).addClass('active');
    $($(this).attr('href')).show();
    event.preventDefault();
  });
});