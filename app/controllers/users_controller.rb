class UsersController < Clearance::UsersController

  before_filter :password_check, only: [:create]

  def create
    @user = user_from_params
    @user.email_confirmation_token = Clearance::Token.new

    if @user.save
      ConfirmationMailer.confirm_email(@user).deliver_later
      flash[:notice] = t("flashes.confirm_your_email")
      redirect_back_or url_after_create
    else
      flash[:warning] = @user.errors.full_messages
      render 'new'
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

  private

  def password_check
    if user_params[:password] != user_params[:password_confirmation]
      flash[:warning] = [t("flashes.wrong_password_confirmation")]
      redirect_to sign_up_path
    end
  end

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new.tap do |user|
      user.email = email
      user.password = password
    end
  end

end