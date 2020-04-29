class SessionsController < ApplicationController
    def new
        
    end
    
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] = "Vous êtes maintenant connecté"
            redirect_to user_path(user)
        else
            flash.now[:alert] = "Email ou mot de passe invalide"
            render 'new'
        end    
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "Vous êtes maintenant déconnecté"
        redirect_to root_path
    end
end