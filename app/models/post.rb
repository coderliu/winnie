class Post < ApplicationRecord
  enum district: { siming: 0 }
  after_create :send_email

  MAILGUN_API_KEY = ENV['MAILGUN_API_KEY']
  MAILGUN_DOMAIN_NAME = ENV['MAILGUN_DOMAIN_NAME']
  RECIVER_ADDRESSES = ENV['RECIVER_ADDRESSES']

  private

  def send_email
    subject = "[#{district}] #{title}"
    subject = "[English]" + subject if include_english
    text = url + "\n" + content
    RestClient.post "https://api:#{MAILGUN_API_KEY}@api.mailgun.net/v3/#{MAILGUN_DOMAIN_NAME}/messages",
                    from: "Ergo <mailgun@#{MAILGUN_DOMAIN_NAME}>",
                    to: RECIVER_ADDRESSES.to_s,
                    subject: subject,
                    text: text
  end
end
