# frozen_string_literal: true

module V1
  class PublisherSerializer < CompanySerializer
    has_many :developers,
      serializer: ::V1::Companies::DeveloperSerializer,
      if: Proc.new { |record| record.developers.any? }
  end
end
