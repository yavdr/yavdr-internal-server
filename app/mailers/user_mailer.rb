class UserMailer < ActionMailer::Base
  default from: "team@marco-scholl.de"

  def commit(payload)
    @payload = payload
    @content = HTTPClient.get_content(@payload['compare'])
    @doc = Nokogiri::HTML(@content)
    @compare = @doc.css("#compare")
    @compare.css("#compare_chooser").remove
    @compare.css('.subtext').remove
    mail to: "develop@marco-scholl.de"
  end
end
