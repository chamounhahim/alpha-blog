class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def new
        @user = User.new
    end

    def edit

    end

    def update
        if @user.update(user_params)
            flash[:notice] = "Votre profil a été mis à jour"
            redirect_to articles_path
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