class StaticController < ApplicationController
  def home
    @last_partners = Partner.includes(:translations).order('created_at DESC').limit(10)
    @slider_ads = SliderAd.where(active: true)
  end

  def empty
    
  end
end