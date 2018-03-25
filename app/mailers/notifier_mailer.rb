class NotifierMailer < ApplicationMailer
  def welcome(address, template_number)
    greeting = 'zzcv20051122@gmail.com'
    mail to: address do |format|
      format.html do
        case template_number
        when '1'
          render template: 'notifier_mailer/welcome', locals: { greeting: greeting }
        when '2'
          render template: 'notifier_mailer/welcome2', locals: { greeting: greeting }
        end
      end
    end
  end
end
