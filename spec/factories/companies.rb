# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { 'MyString' }
    name_complete { 'MyString' }
    url { 'MyString' }
    city { 'MyString' }
    country { 'MyString' }
    workflow_state { :published }

    trait :sony do
      name { 'Sony' }
      name_complete { 'Sony Company' }
      url { 'https://sony.com' }
      country { 'Japan' }
      description { 'the big japanese company' }
    end
  end

  factory :developer, class: Developer, parent: :company do
    type { 'Developer' }

    trait :naughty_dog do
      name { 'Naughty Dog' }
      name_complete { 'Naughty Dog Developer\'s' }
      url { 'https://naughty-dogs.com' }
      description { 'important games developer' }
      city { 'Santa Monica' }
      country { 'United States of America' }
    end
  end

  factory :publisher, class: Publisher, parent: :company do
    type { 'Publisher' }

    trait :sony do
      name { 'Sony' }
      name_complete { 'Sony Publisher' }
      url { 'https://sony.com' }
      country { 'Japan' }
      description { 'the big japanese publisher' }
    end
  end
end
