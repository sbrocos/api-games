# frozen_string_literal: true

module DecoratorFinder
  # Find the best decorator for a context and apply it.
  # If can't find it returns nil.
  def decorate_for(*args)
    DecoratorFinder.decorate_for(self, *args)
  end

  class << self
    def decorate_for(instance, context, _default = nil)
      instance.class.ancestors.lazy
              .map { |klass| decorator_for(context, klass).try(:new, instance) }
              .detect(&:present?)
    end

    private

    # Find the decorator class if exists.
    def decorator_for(context, klass)
      return unless klass.name

      "#{context}/#{klass.name.underscore}_decorator".classify.safe_constantize
    end
  end
end
