class SessionsController < ApplicationController
    def create
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
            payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
            token = JWT.encode(payload, Rails.application.secret_key_base)

            render json: { token: token, user: { id: user.id, email: user.email } }
        else
            render json: { error: "メールアドレスまたはパスワードが間違っています" }, status: :unauthorized
        end
    end
end
