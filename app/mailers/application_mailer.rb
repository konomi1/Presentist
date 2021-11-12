class ApplicationMailer < ActionMailer::Base
  default from: "PRESENTIST<test@presentist.com>"
  layout 'mailer'
end
