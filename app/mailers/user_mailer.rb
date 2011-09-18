class UserMailer < ActionMailer::Base
  default from: "team@marco-scholl.de"

  def commit(payload)
    @payload = payload
    @content = HTTPClient.get_content(@payload['compare'])
    @doc = Nokogiri::HTML(@content)
    @compare = @doc.css("#compare")
    mail to: "develop@marco-scholl.de"
  end
end
