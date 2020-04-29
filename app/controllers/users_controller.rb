class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update]

    def new
        @user = User.new
    end

    def edit

    end

    def index
        @users = User.paginate(page: params[:page], per_page: 6)
    end
    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 3).order("created_at DESC")
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "Votre profil a été mis à jour"
            redirect_to user_path(@user)
        else
            render 'edit'
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Bienvenue sur Alpha Blog #{@user.username} , vous êtes maintenant inscrit."
            redirect_to articles_path
        else
            render 'new'
        end
    end

    private 
    def set_user
        @user = User.find(params[:id]) 
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
        if current_user != @user
            flash[:alert] = "Vous ne pouvez modifier ou supprimer que votre profil"
            redirect_to user_path(@user.id)
        end
    end
end