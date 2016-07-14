class ClearanceMailer < ActionMailer::Base
  def confirm_email(user)
    @user = user
    mail(
      from: Clearance.configuration.mailer_sender,
      to: @user.email,
      subject: I18n.t(
        :confirm_email,
        scope: [:clearance, :models, :clearance_mailer]
      ),
    )
  end
end