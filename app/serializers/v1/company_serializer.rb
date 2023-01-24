# frozen_string_literal: true

module V1
  class CompanySerializer
    include JSONAPI::Serializer

    attributes :name, :url, :city, :country, :workflow_state
  end
end
