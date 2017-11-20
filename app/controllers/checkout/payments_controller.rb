class Checkout::PaymentsController < ApplicationController

  def create
    ad = Ad.find(params[:ad_id])
    ad.processing!

    order = Order.create( ad: ad, buyer_id: current_member.id )
    order.waiting!

    render text: "Processando... Pedido: #{order.status.status_i18n} - Anúncio: #{ad.status.status_i18n}"
  end
end
