class UserMailer < ActionMailer::Base
  default from: "team@yavdr.org"

  def commit(payload)
    @payload = payload
    @compare_url = @payload['compare']
    @content = HTTPClient.get_content(@compare_url)
    @doc = Nokogiri::HTML(@content)
    @compare = @doc.css("#compare")
    @compare.css("#compare_chooser").remove
    @compare.css('.subtext').remove
    mail to: "develop@marco-scholl.de"
  end
end
