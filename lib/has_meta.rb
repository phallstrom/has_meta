require 'cgi'
require 'active_record'
require 'has_meta/version'

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

            if fields.is_a? Proc
              str = fields.call(self)
            else
              field = [*fields].detect{|f| send(f).present?}
              return nil if field.nil?
              str = send(field)
            end

            str = str.to_s.strip
            str.gsub!('&nbsp;', ' ')
            str.gsub!(/<.*?>/, '')

            if meth.to_s == 'keywords'
              str = str.gsub(/[\s,]{2,}/, ',').
                        gsub(/\s+/, ' ').
                        gsub(/^,|,$/, '').
                        strip 
            end

            str = ::CGI::unescapeHTML(str)
            str = (str[0,length - 3] + '...') if str.size > length
            str
          }
        end
      end
    end 

  end
end

ActiveRecord::Base.send :include, HasMeta::Extensions
