class UsersController < Clearance::UsersController

  def create
    @user = user_from_params
    @user.email_confirmation_token = Clearance::Token.new

    if @user.save
      ClearanceMailer.confirm_email(@user).deliver_later
      flash[:notice] = t("flashes.confirm_your_email")
      redirect_back_or url_after_create
    else
      flash[:warning] = @user.errors.full_messages
      redirect_to sign_up_path
    end
  end

  def confirm
    user = User.find_by(email_confirmation_token: params[:token])
    if !user.nil? 
      user.confirm_email
      sign_in user
      flash[:notice] = t("flashes.confirmed_email")
    end
    redirect_to root_path
  end

end