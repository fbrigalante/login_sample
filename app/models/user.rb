class User < ActiveRecord::Base
  include Clearance::User

  def confirm_email
    self.email_confirmed_at = Time.current
    save
  end
end
