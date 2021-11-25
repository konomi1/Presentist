/*global $*/

$(document).on('turbolinks:load',function () {
  // 「新規ボタンをクリック」でフォームの開け閉めをする
  $('#new-btn').on('click', function() {
    // offがついているかで判別
    if($('#friend-new').hasClass('off') == false){
			$('#friend-new').animate({'marginRight':'0px'},300);
		}else{
			$('#friend-new').animate({'marginRight':'400px'},300);
		}
		$('#friend-new').toggleClass('off');
  });
});


$(document).on('turbolinks:load',function () {
  // フォームの高さを画面サイズに。overflowが機能する。
  function scroll(){
    const h = $(window).height();
    $('.form-inner').css("height",h);
  }
  scroll();
  $(window).resize(function(){
    scroll();
  })
});