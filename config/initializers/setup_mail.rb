if Rails.env.development? || Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: '2525',
    authentication: :plain,
    user_name: ENV['SENDGRID_USERNAME'],
    password: ENV['SENDGRID_PASSWORD'],
    domain: 'herokuapp.com',
    enable_starttls_auto: true
  }
end

#
# ActionMailer::Base.smtp_settings = {
#   port: 587,
#   address: 'smtp.mailgun.org',
#   user_name: ENV['MAILGUN_SMTP_LOGIN'],
#   password: ENV['MAILGUN_SMTP_PASSWORD'],
#   # domain: 'app6f89ab31539e4054aa5ae3b68089cd19.mailgun.org',
#   # domain: 'quiet-plains-42389.herokuapp.com',
#   domain: 'herokuapp.com',
#   authentication: :plain,
#   content_type: 'text/html',
#   enable_starttls_auto: true
# }
# ActionMailer::Base.delivery_method = :smtp
