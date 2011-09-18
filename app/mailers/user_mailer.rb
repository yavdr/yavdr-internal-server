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
    @branch = @payload['ref'].gsub("refs/heads/", '')
    @name = @payload['repository']['url'].gsub("https://github.com/", '').gsub("http://github.com/", '')
    subject = "Commit to #{@name}@#{@branch}"
    mail to: User.commit_mails.map(&:email), subject: subject
  end
end
