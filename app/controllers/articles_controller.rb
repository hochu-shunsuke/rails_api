class ArticlesController < ApplicationController
  # 記事の作成・更新・削除をする時だけ、事前に require_login (認証チェック) を走らせる
  before_action :require_login, only: %i[ create update destroy ]
  before_action :set_article, only: %i[ show update destroy ]

   # GET /articles
   def index
    @articles = Article.includes(:comments).all

    # 記事と、それに紐づくコメントを一緒に返す
    render json: @articles.map { |article|
      {
        id: article.id,
        title: article.title,
        content: article.content,
        comments: article.comments.map(&:content)
      }
    }
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_content
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.expect(article: [ :title, :content ])
    end
end
