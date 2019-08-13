module ApplicationHelper
  def flash_type(type)
    return 'danger' if type == 'alert'
    return 'danger' if type == 'error'
    return 'success' if type == 'notice'
  end

  def welcome_text
    str = ""
    str = str + "#{link_to raw("<i class='icon fa fa-sign-out'></i> Sign Out"),
                           logout_path, :method => :Delete}"
    str = str + "#{link_to raw("<i class='icon fa fa-user user'  style='min-height:44px'></i>
                                #{current_user.name.titleize}"), admin_path}"
  end

  def manage_menu
    current_user.nil? ? "normal" : "with-user-bar"
  end

  def tag_value(product)
    # text = product.is_promo? ? "Promo" : (product.is_best_seller? ? "Best Seller" : "")
    text = ""
    return "" if text.blank?
    return "<span class='tg-themetag tg-featuretag'>#{text}</span>"
  end

end
