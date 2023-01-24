# frozen_string_literal: true

module TestResponse
  def json
    Oj.load(body, {})
  end

  def symbols
    Oj.load(body, {}).deep_symbolize_keys
  end

  def data
    return json.map!.each { |elem| elem.deep_symbolize_keys } if json.class == Array

    json.deep_symbolize_keys
  end
end

ActionDispatch::TestResponse.include(TestResponse)
