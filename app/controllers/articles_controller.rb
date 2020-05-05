class ArticlesController < ApplicationController
    #Perform this method before performing show, edit, update, destroy
   before_action :set_article, only: [:show, :edit, :update, :destroy]
   before_action :require_user, except: [:show, :index]
   before_action :require_same_user, only: [:edit, :update, :destroy]

    def show   
        @comment = Comment.new
        @comment.article_id = @article.id
        @comments = @article.comments
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5).order("created_at DESC")
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:notice] = "L'article a été créé"
            redirect_to @article
        else
           render 'new' 
        end

    end

    def edit
    end    

    def update
        if @article.update(article_params)
            flash[:notice] = "L'article a été mis à jour"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article.destroy
        redirect_to articles_path
    end

    # DRY - Making these methods only available to this controller
    private  #Always at the bottom 
    def set_article
        @article = Article.find(params[:id]) 
    end

    def article_params
        params.require(:article).permit(:title, :description, category_ids: [])
    end

    def require_same_user
        if current_user != @article.user and !current_user.admin?
            flash[:alert] =  "Vous ne pouvez modifier ou supprimer que vos articles"
            redirect_to article_path(@article)
        end
    end
    
end