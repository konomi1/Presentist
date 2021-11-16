/*global $*/
//プロフィール画像プレビュー
$(document).on('turbolinks:load', function(){
  $('#user_image').on('change', function (event) {
  // inputの画像を読み込む
    const file = event.target.files[0];
    const reader = new FileReader();
    reader.onload = function (event) {
        $("#preview").attr('src', event.target.result);
    };
  // ファイルを表示
    reader.readAsDataURL(file);
  });
});

// ギフト画像プレビュー