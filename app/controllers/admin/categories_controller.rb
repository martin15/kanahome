class Admin::CategoriesController < Admin::ApplicationController
  before_action :find_category, :only => [:edit, :update, :destroy]
  before_action :validate_page, :only => [:update, :destroy]

  def index
    @categories = Category.page(params[:page]).per(20)
    @no = paging(20)
    puts @no.inspect
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category was successfully create.'
      redirect_to admin_categories_path
    else
      flash[:error] = "Category failed to create"
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      flash[:notice] = 'Category was successfully updated.'
      redirect_to admin_categories_path(page: params[:category][:page])
    else
      flash[:error] = "Category failed to update"
      render :action => :edit
    end
  end

  def destroy
    flash[:notice] =  @category.destroy ? 'Category was successfully deleted.' :
                                           'Category was falied to delete.'
    redirect_to admin_categories_path(page: params[:category][:page])
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end

    def find_category
      @category = Category.find_by_id(params[:id])
      if @category.nil?
        flash[:notice] = "Cannot find the Category with id '#{params[:id]}'"
        redirect_to admin_categories_path
      end
    end

    def validate_page
      params[:category][:page] = params[:category][:page].to_i <= 0 ? 1 : params[:category][:page]
    end
end
