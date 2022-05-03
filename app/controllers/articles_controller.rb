class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # ----------------------------
  public
  # ----------------------------

  def show
    begin
    rescue Exception
      redirect_to articles_path, status: 302
    end
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was created succesfully."
      redirect_to article_path(@article)
    else
      # rails 7 : turbo - reduce page reloads
      render :new, status: 422
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      # turbo - reduce page reloads
      render :edit, status: 422
    end
  end

  def destroy
    @article.destroy
    # turbo - reduce page reloads
    redirect_to articles_path, status: 302
  end

  # ----------------------------
  private
  # ----------------------------
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description) 
  end

end
