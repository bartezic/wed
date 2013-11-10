module ActiveRecordExtension

  extend ActiveSupport::Concern

  # add your instance methods here
  def get_errors
    errors.to_a.map(&:capitalize).join('. ')
  end

  # add your static(class) methods here
  module ClassMethods
    # def bar
    #   "bar"
    # end
  end
end

# include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)