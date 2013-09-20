module Admin
  class PartnersController < BaseController 
    def show
      @partner = Partner.friendly.find(params[:id])
    end

    def edit
      @partner = Partner.friendly.find(params[:id])
    end

    def update
      @partner = Partner.friendly.find(params[:id])
      update_translations
      redirect_to [:admin, @partner]
    end

    def create
      @partner = Partner.create(partner_params)
      @partner.save
      update_translations
      redirect_to [:admin, @partner]
    end

    def destroy
      @partner = Partner.friendly.find(params[:id])
      @partner.destroy

      respond_to do |format|
        format.html { redirect_to admin_partners_path }
        format.json { head :no_content }
      end
    end

    private

    def partner_params
      params[:partner].permit(
        :name, :description, :info, :price, :location_id, 
        :site, :email, :phone, :active, :premium, :premium_to, 
        :avatar, :rating, :encrypted_password, :slug
      )
    end

    def update_translations
      params[:partner][:translations].values.each do |translation|
        I18n.locale = translation['locale'].to_sym
        @partner.update({
          name: translation['name'],
          description: translation['description'],
          info: translation['info'],
          encrypted_password: translation['encrypted_password']
        })
      end
    end
  end
end