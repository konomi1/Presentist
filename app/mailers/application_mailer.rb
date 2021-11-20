class ApplicationMailer < ActionMailer::Base
  default from: "PRESENTIST<test@gmail.com>"
  layout 'mailer'
end
