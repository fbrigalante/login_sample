Clearance.configure do |config|
  config.mailer_sender = "reply@login_sample.com"
  config.routes = false
  config.sign_in_guards = [ConfirmedUserGuard]
end
