class Site::HomeController < ApplicationController
  layout "site"

  def index
    list_category
  end

  private
  
  def list_category
    @categories = Category.order(:description)
    @ads = Ad.limit(5).order(created_at: :desc)
  end
end
