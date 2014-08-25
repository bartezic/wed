module App
  class StaticController < BaseController
    def home
      @last_partners = Partner.order('created_at DESC').limit(10)
      @slider_ads = SliderAd.where(active: true)
    end

    def empty
      
    end
  end
end