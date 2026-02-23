class Article < ApplicationRecord
    # dependent: :destroy は親の記事が消えたら紐づくコメントも全部道連れで消す便利設定
    has_many :comments, dependent: :destroy
end
