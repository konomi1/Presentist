
/*global $*/
/*global location */

$(document).on('turbolinks:load',function () {
// 前ページからのアンカーで表示タブを変更
  //アンカーを取得
  let hash = location.hash;
  hash = (hash.match(/^#tab\d+$/) || [])[0];

  //タブネームにアンカーを入れる
  if($(hash).length){
    var tabname = hash.slice(1) ;
  } else{
    var tabname = "tab1";
  }

  //何番目のタブか
  const tabno = $('#tab-menu li#' + tabname).index();

  $('#tab-panels .panel').hide();
  $('#tab-menu a').removeClass('active');
  $('#tab-panels .panel').eq(tabno).show();
  $('#tab-menu a').eq(tabno).addClass('active');

// タブクリック
  $('#tab-menu a').on('click', function(event) {
    $('#tab-panels .panel').hide();
    $('#tab-menu .active').removeClass('active');
    $(this).addClass('active');
    $($(this).attr('href')).show();
    event.preventDefault();
  });
});