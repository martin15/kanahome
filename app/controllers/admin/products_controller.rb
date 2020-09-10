class Admin::ProductsController < Admin::ApplicationController
  before_action :find_product, :only => [:edit, :update, :destroy]
  before_action :validate_page, :only => [:update, :destroy]

  def index
    @products = Product.all.page(params[:page]).per(20)
    @no = paging(20)
  end

  def new
    @product = Product.new
    @categories = Category.all
    @product.product_images.build
    @compatibility = Product::COMPATIBILITY
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = 'product was successfully create.'
      redirect_to admin_products_path
    else
      @categories = Category.all
      @product.product_images.build
      @compatibility = Product::COMPATIBILITY
      flash[:error] = "product failed to create"
      render :action => :new
    end
  end

  def edit
    @categories = Category.all
    if @product.product_images.blank?
      @product.product_images.build
    end
    @compatibility = Product::COMPATIBILITY
  end

  def update
    if @product.update_attributes(product_params)
      flash[:notice] = 'product was successfully updated.'
      redirect_to admin_products_path(page: params[:product][:page])
    else
      @categories = Category.all
      if @product.product_images.blank?
        @product.product_images.build
      end
      @compatibility = Product::COMPATIBILITY
      flash[:error] = "product failed to update"
      render :action => :edit
    end
  end

  def destroy
    flash[:notice] =  @product.destroy ? 'product was successfully deleted.' :
                                           'product was falied to delete.'
    redirect_to admin_products_path(page: params[:product][:page])
  end

  private

    def product_params
      params.require(:product).permit(:name, :price, :short_description, :description,
                                      :specification, :feature, :category_id, compatibility: [],
                                      product_images_attributes: [:id, :image, :_destroy])
    end

    def find_product
      @product = Product.find_by_id(params[:id])
      if @product.nil?
        flash[:notice] = "Cannot find the product with id '#{params[:id]}'"
        redirect_to admin_products_path
      end
    end

    def validate_page
      params[:product][:page] = params[:product][:page].to_i <= 0 ? 1 : params[:product][:page]
    end
end
