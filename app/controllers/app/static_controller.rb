module App
  class StaticController < BaseController
    def home
      @last_partners = Partner.active.order('created_at DESC').limit(10)
      @slider_ads = SliderAd.where(active: true).order('random()')
    end

    def empty
      
    end

    def about_us
      
    end
  end
end