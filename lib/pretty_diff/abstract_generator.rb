require 'cgi'

module PrettyDiff
  class AbstractGenerator

    def self.[](tgt)
      new(tgt)
    end

    def initialize(tgt)
      target_name = class_to_target_name(tgt.class)
      instance_variable_set("@#{target_name}", tgt)
      class_eval do
        attr_accessor(target_name)
      end
    end

    def generate
      raise 'Not implemented!'
    end

  protected

    def tag(name, options=nil, open=false)
      "<#{name}#{tag_options(options) if options}#{open ? ">" : " />"}"
    end

    def content_tag(name, options=nil, &block)
      "<#{name}#{tag_options(options) if options}>#{block.call}</#{name}>"
    end

    def tag_options(options)
      return if options.blank?
      attrs = []
      options.each_pair do |key, value|
        unless value.nil?
          attrs << %(#{key}="#{h(value)}")
        end
      end
      " #{attrs.sort * ' '}" unless attrs.empty?
    end

    def h(t)
      CGI.escapeHTML(t)
    end

    def class_to_target_name(c)
      c.to_s.split('::').last.gsub(/Gen(erator)?\z/, '').gsub(/(.)([A-Z])/,'\1_\2').downcase
    end
  end
end
