class Site::HomeController < ApplicationController
  layout "site"

  def index
    list_category
  end

  private
  
  def list_category
    @categories = Category.order_by_description
    @ads = Ad.last_syx
  end
end
