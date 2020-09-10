class HomeController < ApplicationController

  def index
    @web_banners = Banner.where("b_type = 'web' or b_type = '' or b_type is null ")
    @mobile_banners = Banner.where("b_type = 'mobile'")

    @contact = Contact.new
    @kompor_induksi = Category.find_by_permalink('kompor-induksi')
    @kitchenware = Category.find_by_permalink('kitchenware')
    @kompor_induksi_products = @kompor_induksi.products
    @kitchenware_products = @kitchenware.products
  end

  def kompor_induksi
  end

  def product_detail
    @product = Product.find_by_permalink(params[:permalink])
    if @product.nil?
      redirect_to root_path
      return
    end
    @images = @product.product_images.order("is_primary desc")
    @feature_details = @product.product_feature_details.order("order_no")
  end

  def contact_us
    @contact = Contact.new(contact_params)
    if verify_recaptcha(model: @contact) && @contact.save
      # ContactUsMailer.notification_user(@contact, the_domain).deliver_now
      # ContactUsMailer.notification_dev(@contact, the_domain).deliver_now
      # ContactUsMailer.notification_admin(@contact, the_domain).deliver_now
      flash[:notice] = 'Message was successfully sent.'
      redirect_to root_path(anchor: "hubungi-kami")
    else
      flash[:error] = "Message failed to send"
      render :action => :index
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :subject, :content)
    end
end
