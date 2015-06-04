class Video < ActiveRecord::Base
  default_scope { order('position DESC, id DESC') }
  belongs_to :partner

  validates :link, presence: true
  validates :link, format: { with: /youtu\.be|youtube|vimeo/i }

  after_create do |video|
    partner = video.partner
    partner.save unless partner.active?
  end

  after_destroy do |video|
    Rails.cache.delete("video_#{video.link}")
  end

  def external_link
    get_link
  end

  def cover(size = :medium)
    get_cover(size)
  end

  def title
    get_info['title'] if get_info
  end

  def description
    get_info['description'] if get_info
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
        get_info[get_cover_sizes[size].to_s] if get_info
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
      @get_info ||= Rails.cache.fetch("video_#{link}", expires_in: 1.day) do 
        if link.include? 'youtu'
          res = RestClient.get("https://www.googleapis.com/youtube/v3/videos?id=#{get_id}&part=snippet,contentDetails,statistics,status&key=AIzaSyB9VXa_UnkLQJap2UmGuuJgNUMULRgSyms")
          JSON.parse(res)['items'][0]['snippet']
        elsif link.include? 'vimeo'
          res = RestClient.get("http://vimeo.com/api/v2/video/#{get_id}.json")
          JSON.parse(res).first
        end
      end
    end
end
