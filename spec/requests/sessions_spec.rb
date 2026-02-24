require 'rails_helper'

RSpec.describe "Sessions (Login API)", type: :request do
  describe "POST /login" do
    # テストの前に、ダミーのユーザーを作っておく
    let!(:user) { User.create(email: "rspec@example.com", password: "password123") }

    context "正しいメールアドレスとパスワードを送った場合" do
      it "ステータス200が返り、JWTトークンが取得できること" do
        post "/login", params: { email: "rspec@example.com", password: "password123" }

        expect(response).to have_http_status(200)       # 200が返るはず！

        json = JSON.parse(response.body)
        expect(json["token"]).to be_present             # トークンが存在するはず！
        expect(json["user"]["email"]).to eq "rspec@example.com" # メアドが合ってるはず！
      end
    end

    context "間違ったパスワードを送った場合" do
      it "ステータス401（Unauthorized）が返り、エラーメッセージが出ること" do
        post "/login", params: { email: "rspec@example.com", password: "wrong_password" }

        expect(response).to have_http_status(401)       # 401エラーが返るはず！

        json = JSON.parse(response.body)
        expect(json["error"]).to eq "メールアドレスまたはパスワードが間違っています"
      end
    end
  end
end
