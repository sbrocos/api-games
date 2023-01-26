# frozen_string_literal: true

class ApplicationController < ActionController::API
  def serializer(resource, options = {})
    V1.const_get("#{self.class.name.demodulize.remove('Controller').singularize}Serializer")
      .new(resource, options)
      .serializable_hash.to_json
  end
end
