class CommentsController < ApplicationController
    before_action :set_article, only: [:destroy]
    before_action :require_user

    def index
        
    end
    
    def new
        @comment = Comment.new
    end

    def create
        @comment = Comment.new(comment_params)
        @comment.article_id = params[:article_id]
        @comment.user_id = current_user.id
            if @comment.save
                flash[:notice] = "Votre commentaire a été publié"
                redirect_to article_path(@comment.article_id)
            else
            render 'new' 
            end

    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        flash[:danger] = "Votre commentaire a été supprimé"
        redirect_to article_path(@article)
    end


    private

    def comment_params
        params.require(:comment).permit(:body, :article_id, :user_id)
    end   

    def set_article
        @article = Article.find(params[:article_id])
    end

end
