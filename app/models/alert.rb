class Alert < ApplicationRecord
  belongs_to :user
  belongs_to :med

  validates_presence_of :med, :alert_time

  after_create :send_text

  def send_text
    @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
    message = @client.account.sms.messages.create(
       :from => ENV["TWILIO_NUMBER"],
       :to => "+1#{user.phone_num}",
       :body => "Hey, #{user.name}! This is a reminder from RemindMe to remind you to take #{med.med_name}"
    )
    puts message.to
  end

  def when_to_run
    alert_time
  end

  handle_asynchronously :send_text, :run_at => Proc.new {|i| i.when_to_run}
end
