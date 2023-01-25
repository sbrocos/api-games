# frozen_string_literal: true

RSpec::Matchers.define :have_status_and_error do |status, error|
  match do |response|
    description { "returns a #{error['code']}" }
    expect(response.status).to eq status
    error_matcher = error ? include_a_hash(error.as_json) : be(nil)
    expect(Oj.load(response.body, {})['errors']).to error_matcher
  end

  failure_message do |actual|
    errors = if error
      "errors should include: #{error.as_json.pretty_inspect}"
    else
      'no errors'
    end

    "status should be #{status}, actual #{actual.try(:status)}\n" \
    "and #{errors}, actual: #{actual.try(:json).pretty_inspect}"
  end
end

def be_a_missing_exception_of(field)
  have_status_and_error(400, field: field.to_s,
                             code: "exception.missing_#{field}")
end

def be_an_invalid_exception_of(field)
  have_status_and_error(400, field: field.to_s,
                             code: "exception.invalid_#{field}")
end
