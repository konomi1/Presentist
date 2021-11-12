# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview
  def remind_mail
    event = Event.first
    EventMailer.remind_mail(event)
  end
end
