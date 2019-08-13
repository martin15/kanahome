class ProductsController < ApplicationController
  def index
    @category = Category.find_by_permalink(params[:cat_permalink])
    if @category.nil?
      (redirect_to root_path) if Category.default_category.nil?
      redirect_to products_path(Category.default_category.id)
    end
    @products = @category.products
    @categories = Category.parent_categories 
  end

  def show
    @category = Category.find_by_permalink(params[:cat_permalink])
    if @category.nil?
      @category = Category.default_category
      (redirect_to root_path) if @category.nil?
      redirect_to products_path(@category.permalink)
    end

    @product = @category.products.find_by_permalink(params[:permalink])
    if @product.nil?
      redirect_to products_path(@category.permalink) 
    end
    @product_images = @product.product_images

  end
end
