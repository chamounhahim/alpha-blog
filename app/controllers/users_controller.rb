class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def new
        @user = User.new
    end

    def edit

    end

    def index
        @users = User.paginate(page: params[:page], per_page: 6)
    end
    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 3)
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
end