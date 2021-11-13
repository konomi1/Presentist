# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
# Learn more: http://github.com/javan/whenever

# 絶対パスから相対パス指定
env :PATH, ENV['PATH']
# ログファイルの出力先
set :output, 'log/cron.log'
# ジョブの実行環境の指定(開発環境)。あとで:productionに変更が必要。
set :environment, :development

#通常
# 記念日一週間前をメールで通知
# every 1.days, at: '9:00 am' do
#   runner "Broadcast.send"
# end

# # テスト用
every 1.minutes do
  runner "Broadcast.send"
end
