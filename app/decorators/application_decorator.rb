# frozen_string_literal: true

class ApplicationDecorator
  class << self
    def object(accessor)
      alias_method :object, accessor
    end

    def attributes(attrs)
      delegate(*Array.wrap(attrs), to: :object)
    end
  end
end
