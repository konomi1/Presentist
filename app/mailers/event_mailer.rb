class EventMailer < ApplicationMailer

# 記念日一週間前に贈り物用意をリマインドする
  def remind_mail(event)     #プレビュー用(event)
    # @event = event    #プレビュー用
#    @url = "http://----"
    # メイルチェック用
#    events = Event.where(date: Date.today.since(1.day))
#    events.each do |event|
#      send_mail(event).deliver_now
#    end
    @event = event
    p @event.user.email
    m = mail(
      to: @event.user.email,
      subject: "一週間後に予定された記念日の通知"
      ) do |format|
      format.html
    end
    p m
    return m
    #events = Event.where(date: Date.today.since(1.day), template: 0)
    #events.each do |event|
    #  @event = event
    #  mail(
    #    to: @event.user.email,
    #    subject: "一週間後に予定された記念日の通知"
    #    ) do |format|
    #    format.html
    #  end
    #    pp @event
    #    pp @event.user.email
    #end
  end

  # def send_mail(event)
  #   @event = event
  #   p @event.user.email
  #   m = mail(
  #     to: @event.user.email,
  #     subject: "一週間後に予定された記念日の通知"
  #     ) do |format|
  #     format.html
  #   end
  #   return m
  # end


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
