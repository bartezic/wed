module ApplicationHelper
  def full_year_callendar(days)
    p = "<table class='table table-striped table-bordered table-condensed'><thead><tr><th>Місяць\\Рік</th>"
    days.each { |k,v| p << "<th>#{k}</th>" }
    p << "<tr></thead><tbody>"
    arr = Array.new(12) { Array.new(days.size) }

    days.each_with_index do |(k,v),i|
      v.each { |key, val| 
        arr[key-1][i] = (val.size > 4) && (val.last - val.first == val.size-1) ? "#{val.first} - #{val.last}" : val.join(',')
      }
    end
    arr.each_with_index do |i,ind| 
      if i.compact.any?
        p << "<tr><th>#{t('date.month_names')[ind+1]}</th>"
        i.each{ |j| p << (j ? "<td><span class='label label-warning'>#{j}</span></td>" : '<td>-</td>') }
        p << '</tr>'
      end
    end
    p << '</tbody></table>'  
  end

  def current_partner
    current_user.rolable
  end

  def order_by
    ['id ASC', 'id DESC', 'price ASC', 'price DESC', 'rating ASC', 'name ASC'].include?(cookies[:order]) ? cookies[:order] : 'id DESC';
  end

  def default_meta_tags
    {
      reverse:     true,
      site:        'Місто весільних професіоналів',
      title:       'Каталог весільних послуг',
      description: 'Cоціальна мережа - каталог, яка об’єднує людей що працюють у галузі надання послуг для урочистих подій та людей яким необхідні ці послуги',
      keywords:    "весілля,послуги,каталог,#{@categories.map(&:name).join(',') if @categories}",
      separator:   '|',
      og: {
        image: "#{request.protocol}#{request.host_with_port}#{asset_path('logo_bg.png')}"
      }
    }
  end

  # Devise hacks

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    devise_mapping.to
  end
end