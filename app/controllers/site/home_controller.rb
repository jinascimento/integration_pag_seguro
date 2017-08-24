class Site::HomeController < ApplicationController
  layout "site"

  def index
    list_category
  end

  private
  
  def list_category
    @categories = Category.all
  end
end
