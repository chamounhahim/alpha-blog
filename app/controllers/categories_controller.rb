class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :edit, :update, :destroy]
    before_action :require_admin, only: [:new, :create, :edit, :update]

    def index
        @categories = Category.paginate(page: params[:page], per_page: 5)

    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "La catégorie a été crée"
            redirect_to categories_path
        else
            render 'new' 
        end

    end

    def edit
        
    end

    def update
        if @category.update(category_params)
            flash[:success] = "Le nom de la catégorie a été modifié"
            redirect_to category_path(@category)
        else
            render 'edit'
        end
    end

    def show
       @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
    end

    private 

    def set_category
        @category = Category.find(params[:id]) 
    end

    def category_params
        params.require(:category).permit(:name) 
    end
end
