class MailerJob
  include Sidekiq::Worker

  # MailerJob.perform_later(['zzcv20051122@gmail.com'])
  def perform(address, template_number)
    # Do something later
    NotifierMailer.welcome(address, template_number).deliver_now
  end
end
