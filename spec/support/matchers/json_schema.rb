# frozen_string_literal: true

require 'json-schema'

RSpec::Matchers.define :match_response_schema do |schema, strict = false|
  match do |response|
    schema_directory = "#{Dir.pwd}/spec/support/schemas"
    schema_path = "#{schema_directory}/#{schema}.json"

    JSON::Validator.validate!(schema_path, response.body, strict: true, validate_schema: true) if strict
    JSON::Validator.validate!(schema_path, response.body, strict: false, validate_schema: true)
  end
end
