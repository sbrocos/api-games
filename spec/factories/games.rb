# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    name { 'MyString' }
    url { 'MyString' }
    plot { 'MyString' }
    short_plot { 'MyString' }
    trait :last_of_us do
      name { 'The Last Of Us' }
      url { 'https://thelastofus.org' }
      workflow_state { :published }
      plot { 'a story about Joel and Ellie' }
      short_plot { 'a story about Joel and Ellie' }
    end
  end
end
