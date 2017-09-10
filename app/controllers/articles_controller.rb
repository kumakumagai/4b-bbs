class ArticlesController < ApplicationController
  def index
    @articles = Article.page(params[:page])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save!

    flash[:success] = '記事を作成しました。'

    redirect_to action: :index
  rescue
    render 'new'
  end

  def show
    @article = find_article(params)
  rescue
    redirect_to action: :index
  end

  def edit
    @article = find_article(params)
  rescue
    redirect_to action: :index
  end

  def update
    @article = find_article(params)

    update_service.update!(@article, article_params)

    flash[:success] = '記事を更新しました。'

    redirect_to action: :show
  rescue
    render 'edit'
  end

  def destroy
    @article = find_article(params)
    @article.destroy!

    flash[:success] = '記事を削除しました。'
  rescue
    flash[:error] = '記事の削除に失敗しました。'
  ensure
    redirect_to action: :index
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def find_article(params)
    Article.find(params[:id])
  end

  def update_service
    @update_service ||= ArticleService::UpdateService.new
  end
end
