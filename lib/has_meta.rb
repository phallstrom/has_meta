require "cgi"
require "has_meta/version"

module HasMeta
  module Extensions
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def has_meta(options = {})
        options.each_pair do |meth, fields|
          define_method("meta_#{meth}") {|*args|
            length = args.first if args.is_a? Array
            length ||= 255
            field = [*fields].detect{|f| send(f).present?}
            return nil if field.nil?
            str = send(field).to_s.strip
            str.gsub!('&nbsp;', ' ')
            str.gsub!(/<.*?>/, '')
            str = ::CGI::unescapeHTML(str)
            str = (str[0,length - 3] + '...') if str.size > length
            str
          }
        end
      end
    end 

  end
end

ActiveModel::AttributeMethods.send :include, HasMeta::Extensions
