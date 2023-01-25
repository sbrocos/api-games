# frozen_string_literal: true

module V1
  module ExceptionHandler
    extend ActiveSupport::Concern

    included do
      rescue_from StandardError do |exception|
        render DecoratorFinder.decorate_for(exception, :render).to_render_params
      end
    end
  end
end
