class User < ApplicationRecord
    # この一行を入れるだけで保存時に自動暗号化&authenticateメソッドが使えるようになる
    has_secure_password

    validates :email, presence: true, uniqueness: true
end
