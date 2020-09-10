class Admin::BannersController < Admin::ApplicationController
  before_action :find_banner, :only => [:edit, :update, :destroy, :delete]

  def index
    @banners = Banner.page(params[:page]).per(20)
    @no = paging(20)
  end

  def new
    @banner = Banner.new
    @types = Banner::TYPE
  end

  def create
    @banner = Banner.new(banner_params)
    if @banner.save
      flash[:notice] = 'Banner was successfully create.'
      redirect_to admin_banners_path
    else
      @types = Banner::TYPE
      flash[:error] = "Banner failed to create"
      render :action => :new
    end
  end

  def edit
    @types = Banner::TYPE
  end

  def update
    if @banner.update_attributes(banner_params)
      flash[:notice] = 'Banner was successfully updated.'
      redirect_to admin_banners_path
    else
      @types = Banner::TYPE
      flash[:error] = "Banner failed to update"
      render :action => :edit
    end
  end

  def destroy
    flash[:notice] =  @banner.destroy ? 'Banner was successfully deleted.' :
                                        'Banner was falied to delete.'
    redirect_to admin_banners_path
  end

  private

    def banner_params
      params.require(:banner).permit(:image, :url, :alt, :b_type )
    end

    def find_banner
      @banner = Banner.find_by_id(params[:id])
      if @banner.nil?
        flash[:notice] = "Cannot find the Banner with id '#{params[:id]}'"
        redirect_to admin_banners_path
      end
    end
end
