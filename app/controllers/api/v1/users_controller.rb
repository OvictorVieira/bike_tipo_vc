class Api::V1::UsersController < Api::V1::ApplicationController

  def login
    binding.pry

    @user = UserRepository.find_by_email(params[:email])

    if @user&.valid_password?(params[:password])

      sign_in @user

      render json: @user, status: :ok
    else
      head :unauthorized
    end
  end

  def logout
    current_user.authentication_token = nil

    current_user.save!

    render json: { message: I18n.t('devise.sessions.signed_out') }, status: :ok
  end

end