class Admin::ProductImagesController < Admin::ApplicationController
  protect_from_forgery with: :null_session
  before_action :find_product, :only => [:new, :create, :edit, :update, :destroy]
  before_action :find_product_image, :only => [:edit, :update, :destroy]

  # def index
  #   @product_images = ProductImage.all.page(params[:page]).per(20)
  #   @no = paging(20)
  # end

  def new
    respond_to do |format|
      @product_image = ProductImage.new
      format.js
    end
  end

  def create
    @product_image = ProductImage.new(product_image_params)
    @product_image.product = @product
    if @product_image.save
      flash[:notice] = 'ProductImage was successfully create.'
    else
      flash[:error] = "ProductImage failed to create"
    end
    redirect_to edit_admin_product_path(@product.id)
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @failed_product_image = 0
    if @product_image.update_attributes(product_image_params)
      flash[:notice] = 'ProductImage was successfully updated.'
      redirect_to edit_admin_product_path(@product.id)
    else
      flash[:error] = "ProductImage failed to update"
      @failed_product_image = @product_image.id
      redirect_to edit_admin_product_path(@product.id, failed_product_image: @product_image.id)
    end
  end

  def destroy
    flash[:notice] =  @product_image.destroy ? 'ProductImage was successfully deleted.' :
                                                'ProductImage was falied to delete.'
    redirect_to edit_admin_product_path(@product.id)
  end

  private

    def product_image_params
      params[:product_image] = {image: ""} if params[:product_image].blank?
      params.require(:product_image).permit(:image)
    end

    def find_product_image
      @product_image = ProductImage.find_by_id(params[:product_image_id])
      if @product_image.nil?
        flash[:notice] = "Cannot find the ProductImage with id '#{params[:product_image_id]}'"
        redirect_to admin_products_path
      end
    end

    def find_product
      @product = Product.find_by_id(params[:id])
      if @product.nil?
        flash[:notice] = "Cannot find the Product with id '#{params[:id]}'"
        redirect_to admin_products_path
      end
    end
end
