class MailerJob
  include Sidekiq::Worker

  # MailerJob.perform_later(['zzcv20051122@gmail.com'])
  def perform(address)
    # Do something later
    NotifierMailer.welcome(address).deliver_now
  end
end
