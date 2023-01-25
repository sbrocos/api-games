# frozen_string_literal: true

class DecoratableClass
  include DecoratorFinder

  def decorated?
    false
  end
end

class NonDecoratableClass
  include DecoratorFinder
end

module Scope
  class DecoratableClassDecorator < SimpleDelegator
    def decorated?
      true
    end
  end
end

module WithObjectDecorator
  class ObjectDecorator < SimpleDelegator
  end
end
