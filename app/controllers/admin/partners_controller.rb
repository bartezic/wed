module Admin
  class PartnersController < BaseController
    before_action :set_partner, only: [:show, :edit, :update, :destroy]

    # GET /desks
    # GET /desks.json
    def index
      @partners = Partner.all
    end

    # GET /desks/1
    # GET /desks/1.json
    def show
    end

    # GET /desks/new
    def new
      @partner = Partner.new
    end

    # GET /desks/1/edit
    def edit
    end

    # POST /desks
    # POST /desks.json
    def create
      @partner = Partner.new(partner_params)

      respond_to do |format|
        if @partner.save && update_translations
          format.html { redirect_to [:admin, @partner], notice: 'Partner was successfully created.' }
          format.json { render action: 'show', status: :created, location: @partner }
        else
          format.html { render action: 'new' }
          format.json { render json: @partner.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /desks/1
    # PATCH/PUT /desks/1.json
    def update
      respond_to do |format|
        if @partner.update(partner_params) && update_translations
          format.html { redirect_to [:admin, @partner], notice: 'Partner was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @partner.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /desks/1
    # DELETE /desks/1.json
    def destroy
      @partner.destroy
      respond_to do |format|
        format.html { redirect_to admin_partners_url }
        format.json { head :no_content }
      end
    end

    # GET /desks/import
    def import
      locale = I18n.locale
      I18n.locale = :uk
      categories = Category.all
      {'Фотографи' => 'photographer'}.each do |key, val|
        url = "http://odnalubov.com/#{val}"
        res = RestClient.get(url)

        category_ids = categories.map{ |i| i.id if i.name == key}
        
        Nokogiri::HTML.parse(res,nil,'windows-1251').xpath("//ul[@id='applications']/li/a").first(5).each do |person|
          href = person.attributes['href'].to_s
          res1 = RestClient.get(make_absolute(href, url))
          avatar = "http://odnalubov.com/userprofile/avatars/#{href}.jpg"
          videos = "http://odnalubov.com/userprofile/videos/#{href}/playlist.txt"
          photos = RestClient.get("http://odnalubov.com/userprofile/manage_profile/get_photos.php?user_id=#{href}&start=")
          if !JSON.parse(photos)['nextStart'].empty?
            photos = RestClient.get("http://odnalubov.com/userprofile/manage_profile/get_photos.php?user_id=#{href}&start=#{JSON.parse(photos)['nextStart']}")
          end
          photos = JSON.parse(photos)['files'].map{ |p| "http://odnalubov.com/userprofile/photos/1170790/#{p}"}
          content = Nokogiri::HTML.parse(res1,nil,'windows-1251').xpath("//td[@class='main-bg']/table")
          if content
            price = content[2].search("//span[@class='fs15px']").first.content.strip
            name = content[2].search("//td/span/font[@face='Tahoma']").first.content.strip.gsub(/[\r\n]+/, '<br>')
            description = content[2].css("td span").last.content.strip.gsub(/[\r\n]+/, '<br>')
            #callendar = content[4]
            info = content.xpath("//td[@class='serch33']").first
            info = info.content.strip.gsub(/[\r\n]+/, '<br>') if info
            I18n.locale = :uk
            temp = Partner.new(
              name: name, 
              description: description, 
              info: info, 
              price: price, 
              active: true, 
              category_ids: category_ids, 
              avatar_remote_url: avatar,
              email: "demo_#{Time.now.to_i}@demo.com",
              password: 'password',
              password_confirmation: 'password'
            )
            temp.save
            I18n.locale = :ru
            temp.update(name: translate_API(name), description: translate_API(description, 'html'), info: translate_API(info,'html'))
          end
        end
      end

      I18n.locale = locale
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { head :no_content }
      end
    end

    private
      def translate_API(text, type = 'plain')
        res = RestClient.post('https://translate.yandex.net/api/v1.5/tr.json/translate', { 
          key: 'trnsl.1.1.20130628T094430Z.e271ab766a48ca42.a64b41ec92ce0dbec000a18165f1a02d3d28374e',
          lang: 'uk-ru',
          text: text.to_s,
          format: type
        })
        JSON.parse(res)['text'][0]
      end

      def make_absolute( href, root )
        URI.parse(root).merge(URI.parse(href)).to_s
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_partner
        @partner = Partner.friendly.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def partner_params
        params.require(:partner).permit(
          :name, :description, :info, :price, :location_id, 
          :site, :email, :phone, :active, :premium, :premium_to, 
          :avatar, :rating, :slug, :password, :password_confirmation,
          :avatar_remote_url, :category_ids => [], :location_ids => []
        )
      end

      def update_translations
        params[:partner][:translations].values.each do |translation|
          I18n.locale = translation['locale'].to_sym
          @partner.update({
            name: translation['name'],
            description: translation['description'],
            info: translation['info']
          })
        end
      end
  end
end