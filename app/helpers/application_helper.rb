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
end

module ActionView
  module Helpers
    class FormBuilder
      def globalize_fields_for(locale, *args, &proc)
        raise ArgumentError, "Missing block" unless block_given?
        @index = @index ? @index + 1 : 1
        object_name = "#{@object_name}[translations][#{@index}]"
        object = @object.translations.find_by_locale locale.to_s
        @template.concat @template.hidden_field_tag("#{object_name}[id]", object ? object.id : "")
        @template.concat @template.hidden_field_tag("#{object_name}[locale]", locale)
        if @template.respond_to? :simple_fields_for
          @template.concat @template.simple_fields_for(object_name, object, *args, &proc)
        else
          @template.concat @template.fields_for(object_name, object, *args, &proc)
        end
      end
    end
  end
end

module Globalize
  module Model
    module ActiveRecord
      module Translated
        module Callbacks
          def enable_nested_attributes
            accepts_nested_attributes_for :translations
          end
        end
        module InstanceMethods
          def after_save
            init_translations
          end
          # Builds an empty translation for each available 
          # locale not in use after creation
          def init_translations
            I18n.translated_locales.reject{|key| key == :root }.each do |locale|
              translation = self.translations.find_by_locale locale.to_s
              if translation.nil?
                translations.build :locale => locale
                save
              end
            end
          end
        end
      end
    end
  end
end