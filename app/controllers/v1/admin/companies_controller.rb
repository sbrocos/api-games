# frozen_string_literal: true

module V1
  module Admin
    class CompaniesController < BaseController
      include Serializable,
              Companies::Serializable,
              Companies::Typezable

      # POST /v1/admin/companies
      def create
        @company = Company.create!(company_params)

        render json: serializer_with_options(company), status: :created
      end

      # PATCH/PUT /v1/admin/companies/1
      def update
        company.update!(company_params)

        render json: serializer(company)
      end

      # DELETE /v1/admin/companies/1
      def destroy
        company.unpublished!

        head :no_content
      end

      private

      def define_type
        @company.type
      end

      # Only allow a trusted parameter "white list" through.
      def company_params
        params.require(:company).permit(%i[name name_complete type url description city country])
      end
    end
  end
end
