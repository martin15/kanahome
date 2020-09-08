class Admin::ProductFeatureDetailsController < Admin::ApplicationController
  protect_from_forgery with: :null_session
  before_action :find_product
  before_action :find_product_feature_detail, :only => [:edit, :update, :destroy]

  def index
    @product_feature_details = @product.product_feature_details.page(params[:page]).per(20)
    @no = paging(20)
  end

  def new
    @product_feature_detail = ProductFeatureDetail.new
  end

  def create
    @product_feature_detail = ProductFeatureDetail.new(product_feature_detail_params)
    @product_feature_detail.product = @product
    if @product_feature_detail.save
      flash[:notice] = 'ProductFeatureDetail was successfully create.'
    else
      flash[:error] = "ProductFeatureDetail failed to create"
    end
    redirect_to admin_product_feature_details_path(@product.id)
  end

  def edit
  end

  def update
    if @product_feature_detail.update_attributes(product_feature_detail_params)
      flash[:notice] = 'ProductFeatureDetail was successfully updated.'
      redirect_to admin_product_feature_details_path(@product.id)
    else
      flash[:error] = "ProductFeatureDetail failed to update"
      @failed_product_feature_detail = @product_feature_detail.id
      redirect_to edit_admin_product_feature_detail_path(@product.id)
    end
  end

  def destroy
    flash[:notice] =  @product_feature_detail.destroy ? 'ProductFeatureDetail was successfully deleted.' :
                                                'ProductFeatureDetail was falied to delete.'
    redirect_to admin_product_feature_details_path(@product.id)
  end

  private

    def product_feature_detail_params
      params.require(:product_feature_detail).permit( :icon_title, :icon, :title, :image, 
                                                      :description, :order )
    end

    def find_product_feature_detail
      @product_feature_detail = ProductFeatureDetail.find_by_id(params[:product_feature_detail_id])
      if @product_feature_detail.nil?
        flash[:notice] = "Cannot find the ProductFeatureDetail with id '#{params[:product_feature_detail_id]}'"
        redirect_to admin_product_feature_details_path(@product.id)
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
