class Site::Profile::AdsController < Site::ProfileController
  before_action :set_ad, only: [:edit, :update]
  
  def index
    @ads = Ad.ad_for_current_member(current_member)
  end
  
  def edit
    # Set Ad via before_Action
  end

  def update
    if @ad.update(params_ad)
      redirect_to site_profile_ads_path, notice: "Anúncio atualizado com sucesso!"
    end
  end

  def new
    @ad = Ad.new
  end

  def create
    @ad = Ad.new(params_ad)
    @ad.member = current_member
    if @ad.save
      redirect_to site_profile_ads_path, notice: "Anúncio criado com sucesso!"
    else
      render :new
    end
  end

  private

  def set_ad
    @ad = Ad.find(params[:id])
  end

  def params_ad
    params.require(:ad).permit(:title, :category_id, :price, :description, :picture, :id)
  end
end
