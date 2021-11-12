class EventMailer < ApplicationMailer

# 記念日一週間前に贈り物用意をリマインドする
  def remind_mail(event)
    @url = "http://----"
    @event = event
    p @event.user.email
    m = mail(
      to: @event.user.email,
      subject: "一週間後に予定された記念日の通知"
      ) do |format|
      format.html
    end
    return m
  end

# したのはいらないかも。一度確認を。
  def send_mail(event)
    @event = event
    p @event.user.email
    m = mail(
      to: @event.user.email,
      subject: "一週間後に予定された記念日の通知"
      ) do |format|
      format.html
    end
    return m
  end


# これだと@eventが定まらない
# events = Event.where(date: Date.today.since(7.day))
# to_emails = events.joins(:user).distinct.pluck(:email)
# mail(subject: "一週間後に予定された記念日の通知", bcc: to_emails)

# 複数回メールが飛んでしまう?
# events = Event.where(date: Date.today.since(7.day))
# events.each do |event|
#   @event = event
#   mail(subject: "一週間後に予定された記念日の通知", bcc: @event.user.email )
end
