class PartnerAdsController < ApplicationController
  def index
    @partner_ads = PartnerAd.includes(:translations).page params[:page]
  end
end