class CommentsController < ApplicationController
    def create
        # 1. URLの :article_id を元に、親となる「記事」を探してくる
        @article = Article.find(params[:article_id])

        # 2. その記事に紐づくコメントを新しく作る（送られてきたパラメータ :content を使う）
        @comment = @article.comments.create!(content: params[:content])

        # 3. 成功レスポンスを返す
        render json: {
            message: "コメントが正常に作成されました",
            article_title: @article.title,
            comment: @comment
        }, status: :created
    end
end
