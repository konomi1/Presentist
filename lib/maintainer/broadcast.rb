class Broadcast
  def self.send
    p "Broadcast"
    events = Event.where(date: Date.today.since(6.day))
    events.each do |event|
      EventMailer::remind_mail(event).deliver_now
    end
  end
end
