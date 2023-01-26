# frozen_string_literal: true

shared_examples_for :good_response do |schema_name, strict = true|
  it do
    expect(response).to have_http_status(200)
    expect(response).to match_response_schema(schema_name, strict)
    expect(response.body).to eq(serializer)
  end
end
