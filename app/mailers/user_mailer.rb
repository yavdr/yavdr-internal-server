class UserMailer < ActionMailer::Base
  default from: "team@marco-scholl.de"

  def commit(payload)
    @payload = payload
    mail to: "develop@marco-scholl.de"
  end
end
