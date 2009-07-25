module Resourceful
  module Model

    class Xml < Resourceful::Model::Base
      
      attr_reader :xml

      def self.get(path, params, xpath, force=false)
        opts = {
          :format => 'xml',
          :params => params || {},
          :force => force
        }
        new(super(path, opts).xpath(xpath))
      end
      def self.get_collection(path, params, xpath, force=false)
        opts = {
          :format => 'xml',
          :params => params || {},
          :force => force
        }
        super(path, opts) do |data|
          data.xpath(xpath)
        end
      end

      def initialize(xml)
        @xml = xml
      end
      
      protected
      
      def self.attribute(name, type, config={})
        config[:path] ||= name
        super(name, type, config)
      end
      
      def attribute(config)
        node = get_node("./#{config[:path]}")
        node.content rescue nil
      end
        
      def self.get_node(xml, path)
        xml.xpath(path.to_s).first
      end
      def get_node(path)
        self.class.get_node(@xml, path)
      end

      def self.xml_root_name(xml)
        xml.root.name
      end
      def xml_root_name
        self.class.xml_root_name(@xml)
      end

    end

  end
end