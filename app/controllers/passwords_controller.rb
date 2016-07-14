class PasswordsController < Clearance::PasswordsController

  before_filter :password_check, only: [:update]

  private

  def password_check
    if params[:password_reset][:password] != params[:password_reset][:password_confirmation]
      flash[:warning] = [t("flashes.wrong_password_confirmation")]
      redirect_to edit_user_password_url(params[:user_id], token: params[:token])
    end
  end
end