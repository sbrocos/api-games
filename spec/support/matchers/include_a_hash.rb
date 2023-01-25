# frozen_string_literal: true

RSpec::Matchers.define :include_a_hash do |hash|
  match { |actual| expect(actual).to include a_hash_including(hash) }

  failure_message do |actual|
    "expected #{actual.pretty_inspect} to include #{hash.pretty_inspect}"
  end
end
