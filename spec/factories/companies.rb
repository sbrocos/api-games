# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    company_type { 1 }
    name { 'MyString' }
    url { 'MyString' }
    city { 'MyString' }
    country { 'MyString' }
    status { 1 }
  end
end
