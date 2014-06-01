class StaticController < ApplicationController
  def home
    @last_partners = Partner.includes(:translations).order('created_at DESC').limit(10)
    @slider_ads = SliderAd.where(active: true)
    @partner_ad = PartnerAd.where('partner_id IS NOT NULL').includes(:translations).order("RANDOM()").limit(1).first
  end

  def empty
    
  end
end