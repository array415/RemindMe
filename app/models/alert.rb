class Alert < ApplicationRecord
  belongs_to :user
  belongs_to :med

  @@REMINDER_TIME = 5.minutes

  def send_text
    @client = Twilio::REST::Client.new ENV[twilio_sid], ENV[twilio_token]
    @message = @client.account.sms.messages.create(
       from: ENV[twilio_number],
       to: "+14153610872",
       body: 'This is a test for RemindMe'
    )
  end

  def when_to_run
    alert_time - @@REMINDER_TIME
  end

end
