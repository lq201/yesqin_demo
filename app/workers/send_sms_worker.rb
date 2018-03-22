class SendSmsWorker
  include Sidekiq::Worker

  def perform(phone_number)
    YesSms::Tencent.send_validation_code(phone_number)
  end
end
