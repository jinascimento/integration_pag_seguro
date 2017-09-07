class Site::Profile::AdsController < Site::ProfileController
  before_action :set_ad, only: [:edit]
  
  def index
    @ads = Ad.ad_for_current_member(current_member)
  end
  
  def edit
    # Set Ad via before_Action
  end

  private

  def set_ad
    @ad = Ad.find(params[:id])
  end
end
