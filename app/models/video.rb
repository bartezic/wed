class Video < ActiveRecord::Base
  belongs_to :partner

  after_create do |video|
    partner = video.partner
    partner.save unless partner.active?
  end

  def external_link
    get_link
  end

  def cover(size = :medium)
    get_cover(size)
  end

  def title
    get_info['title']
  end

  def description
    get_info['description']
  end

  private

    def get_id
      @get_id ||= if link.include? 'youtube'
        link.split(/&|#/).first.split('=').last
      elsif link.include? 'youtu.be'
        link.split('&').first.split('/').last
      elsif link.include? 'vimeo'
        link.split('&').first.split('/').last
      end
    end

    def get_link
      @get_link ||= if link.include? 'youtu'
        "http://www.youtube.com/embed/#{get_id}"
      elsif link.include? 'vimeo'
        "http://player.vimeo.com/video/#{get_id}"
      end
    end

    def get_cover(size)
      @get_cover = if link.include? 'youtu'
        "http://img.youtube.com/vi/#{get_id}/#{get_cover_sizes[size]}.jpg"
      elsif link.include? 'vimeo'
        get_info[get_cover_sizes[size].to_s]
      end
    end

    def get_cover_sizes
      @get_cover_sizes ||= if link.include? 'youtu'
        {
          small: :default,
          medium: :mqdefault,
          large: :hqdefault,
          big: :sddefault
        }
      elsif link.include? 'vimeo'
        {
          small: :thumbnail_small,
          medium: :thumbnail_large,
          # medium: :thumbnail_medium,
          large: :thumbnail_large,
          big: :thumbnail_large
        }
      end
    end

    def get_info
      @get_info ||= if link.include? 'youtu'
        res = RestClient.get("https://gdata.youtube.com/feeds/api/videos/#{get_id}?v=2&alt=jsonc")
        JSON.parse(res)['data']
      elsif link.include? 'vimeo'
        res = RestClient.get("http://vimeo.com/api/v2/video/#{get_id}.json")
        JSON.parse(res).first
      end
    end
end
