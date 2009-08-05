require 'mechanize'
require File.join(File.dirname(__FILE__), 'base.rb')

module Resourceful
  module Agent
    class Mechanize < Resourceful::Agent::Base
      
      def initialize(args={})
        super(args)
        self.log = yield if block_given?
        @mechanize = ::WWW::Mechanize.new { |obj| obj.log = @logger }
      end

      def get(path, opts={})
        super(path, opts) do |path|
          resp = ""
          @mechanize.get("#{@host}#{path}") do |page|
            resp = if block_given?
              yield page
            else
              page
            end
          end
          resp.body
        end
      end
    
      protected
      
      def agent
        @mechanize
      end
      
    end
  end
end
