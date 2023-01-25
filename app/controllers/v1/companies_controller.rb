# frozen_string_literal: true

module V1
  class CompaniesController < ::V1::BaseController
    include Companies::Typezable,
            Companies::Serializable
    def index
      render json: serializer(companies)
    end
    # GET /v1/companies/:uuid
    def show
      render json: serializer_with_options(company)
    end
  end
end
