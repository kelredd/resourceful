module Resourceful
  module Version
    
    MAJOR = 0
    MINOR = 5
    TINY  = 10
    
    def self.to_s # :nodoc:
      [MAJOR, MINOR, TINY].join('.')
    end
    
  end
end