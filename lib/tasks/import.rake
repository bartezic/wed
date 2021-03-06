namespace :import do 
  task partners: :environment do
    puts "Import partners from odnalubov.com"
    # I18n.locale = :uk
    cats = Category.all

    {
      'Фотографи' => 'photographer',
      'Відеозйомка' => 'videos',
      'Ведучі' => 'leading',
      'Музиканти' => 'musicians',
      'Артисти' => 'singersandbands',
      'Шоу-програма' => 'showprogram',
      'Візажисти' => 'makeup',
      'Координатори' => 'coordinator',
      'Флористика' => 'floral',
      'Декорування' => 'decorators',
      'Виїзна церемонія' => 'bceremony',
      'Кейтерінг' => 'catering'
    }.each do |key, val|
      url = "http://odnalubov.com/#{val}"
      res = RestClient.get(url)
      partners = Nokogiri::HTML.parse(res,nil,'windows-1251').xpath("//ul[@id='applications']/li/a").map{ |i| i.attributes['href'].to_s }
      partners.each do |href|
        puts "partner #{href}"
        res1 = RestClient.get(make_absolute(href, url))
        avatar = "http://odnalubov.com/userprofile/avatars#{href}.jpg"
        videos = "http://odnalubov.com/userprofile/videos#{href}/playlist.txt"
        photos = RestClient.get("http://odnalubov.com/userprofile/manage_profile/get_photos.php?user_id=#{href}&start=")
        if !JSON.parse(photos)['nextStart'].empty?
          photos = RestClient.get("http://odnalubov.com/userprofile/manage_profile/get_photos.php?user_id=#{href}&start=#{JSON.parse(photos)['nextStart']}")
        end
        photos = JSON.parse(photos)['files'].map{ |p| { asset_remote_url: "http://odnalubov.com/userprofile/photos#{href}/#{CGI.escape(p)}" } if p}.first(10).compact
        content = Nokogiri::HTML.parse(res1,nil,'windows-1251').xpath("//td[@class='main-bg']/table")
        if content
          price = content[2].search("//span[@class='fs15px']").first.content.strip
          name = content[2].search("//td/span/font[@face='Tahoma']").first.content.strip.gsub(/[\r\n]+/, '<br>')
          description = content[2].css("td span").last.content.strip.gsub(/[\r\n]+/, '<br>')
          
          # days
          day_ids = []
          content[4].css('td.cal1').each_with_index do |month, index|
            arr = month.css('span').last.content.gsub(/[^\d]/, ',').split(',')
            arr.delete('')
            day_ids << Day.where(day_of_life: arr.map { |e| "2013-#{index+1}-#{e}" }).pluck(:id)
          end

          # info
          info = content.xpath("//td[@class='serch33']").first
          info = info.content.strip.gsub(/[\r\n]+/, '<br>') if info
          
          # I18n.locale = :uk
          temp = Partner.new(
            name: name, 
            description: description, 
            info: info, 
            price: price, 
            active: true, 
            day_ids: day_ids.flatten,
            location_ids: Location.all.order("RANDOM()").limit(4).pluck(:id),
            category_ids: cats.map{ |i| i.id if i.name == key },
            user_attributes: {
              avatar_remote_url: avatar,
              email: "demo_#{Time.now.to_i}@demo.com",
              password: 'password',
              password_confirmation: 'password'
            },
            galleries_attributes: [{
              name: "demo_#{Time.now.to_i}_gallery",
              photos_attributes: photos
            }]
          )
          temp.user.skip_confirmation!
          temp.save

          # I18n.locale = :ru
          # temp.update(
          #   name: translate_API(name), 
          #   description: translate_API(description, 'html'), 
          #   info: translate_API(info,'html')
          # )
        end
      end
    end
  end

  task categories: :environment do
    puts "Import categories from odnalubov.com"
    res = RestClient.get('http://odnalubov.com/')
    Nokogiri::HTML.parse(res,nil,'windows-1251').xpath("//div[@id='navigation']/ul/li/a[@class='side']").each do |cat|
      slug = cat.attributes['href'].to_s
      uk = cat.search('span').last.content.to_s
      # ru = translate_API(uk.to_s)

      # I18n.locale = :uk
      temp = Category.new(name: uk, name_sing: uk)
      temp.save
      # I18n.locale = :ru
      # temp.update(name: ru, name_sing: ru)
    end
  end
end

namespace :add do 
  task days: :environment do
    puts "Add Days"
    Day.create!(day_of_life: Time.now.to_date)
    365.times {Day.create!(day_of_life: Day.order("day_of_life ASC").last.day_of_life + 1) }
  end

  task regions: :environment do
    puts 'Add regions'
    regions = [ ['Автономная Республика Крым',  'АР Крим'],
                ['Винницкая область', 'Вінницька область'],
                ['Волынская область', 'Волинська область'],
                ['Днепропетровская область', 'Дніпропетровська область'],
                ['Донецкая область', 'Донецька область'],
                ['Житомирская область', 'Житомирська область'],
                ['Закарпатская область', 'Закарпатська область'],
                ['Запорожская область', 'Запорізька область'],
                ['Ивано-Франковская область', 'Івано-Франківська область'],
                ['Киевская область', 'Київська область'],
                ['Кировоградская область', 'Кіровоградська область'],
                ['Луганская область', 'Луганська область'],
                ['Львовская область', 'Львівська область'],
                ['Николаевская область', 'Миколаївська область'],
                ['Одесская область', 'Одеська область'],
                ['Полтавская область', 'Полтавська область'],
                ['Ровненская область', 'Рівненська область'],
                ['Сумская область', 'Сумська область'],
                ['Тернопольская область', 'Тернопільська область'],
                ['Харьковская область', 'Харківська область'],
                ['Херсонская область', 'Херсонська область'],
                ['Хмельницкая область', 'Хмельницька область'],
                ['Черкасская область', 'Черкаська область'],
                ['Черниговская область', 'Чернігівська область'],
                ['Черновицкая область', 'Чернівецька область']]
    regions.each do |obl|
      # I18n.locale = :uk
      temp = Location.new(name: obl[1].gsub('область', '').strip)
      temp.save

      # I18n.locale = :ru
      # temp.update(name: obl[0])
    end
  end

  task local_categories: :environment do
    {
      'Фотографи' => 'photographer',
      'Відеозйомка' => 'videos',
      'Ведучі' => 'leading',
      'Музиканти' => 'musicians',
      'Артисти' => 'singersandbands',
      'Шоу-програма' => 'showprogram',
      'Візажисти' => 'makeup',
      'Координатори' => 'coordinator',
      'Флористика' => 'floral',
      'Декорування' => 'decorators',
      'Виїзна церемонія' => 'bceremony',
      'Кейтерінг' => 'catering'
    }.each do |key, val|
      Category.create(name: key, name_sing: key)
    end
  end
end

task general_import_task: :environment do
  puts 'General task for migrate data...'
  Rake::Task['add:days'].invoke
  Rake::Task['add:regions'].invoke
  Rake::Task['import:categories'].invoke
  Rake::Task['import:partners'].invoke
  puts 'Finished general task.'
end


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