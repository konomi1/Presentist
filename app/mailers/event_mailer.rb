class EventMailer < ApplicationMailer
  # 記念日一週間前に贈り物用意をリマインドする
  def remind_mail(event)
    @url = "http://----"
    @event = event
    mail(
      bcc: @event.user.email,
      subject: "一週間後に予定された記念日の通知"
    )
  end
end
