# Preview all emails at http://localhost:3000/rails/mailers/notifier
class NotifierPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/notifier/welcome
  def welcome_1
    NotifierMailer.welcome('zzcv20051122@gmail.com', '1')
  end

  def welcome_2
    NotifierMailer.welcome('zzcv20051122@gmail.com', '2')
  end
end
