# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    name { 'MyString' }
    url { 'MyString' }
    status { 1 }
    plot { 'MyString' }
    short_plot { 'MyString' }
  end
end
