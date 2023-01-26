# frozen_string_literal: true

module V1
  class CompanySerializer
    include JSONAPI::Serializer

    attributes :name, :name_complete, :url, :city, :country, :description
  end
end
