class ApplicationController < ActionController::API
  # リクエストのヘッダーに含まれるトークンを解析して、ログイン済みか確認する処理
  def require_login
    # Authorization: Bearer <token> の形からトークン部分だけを取り出す
    auth_header = request.headers["Authorization"]
    token = auth_header.split(" ").last if auth_header

    begin
      # 秘密鍵でトークンを解読（decode）する
      decoded_token = JWT.decode(token, Rails.application.secret_key_base).first

      # 解読した情報からユーザーIDを取り出し、DBからユーザーを探して @current_user にセットする
      @current_user = User.find(decoded_token["user_id"])
    rescue StandardError
      # トークンがない、不正、期限切れの場合は一律でエラー（401 Unauthorized）を返す
      render json: { error: "ログインが必要です（有効なトークンが含まれていません）" }, status: :unauthorized
    end
  end
end
