FactoryBot.define do
    factory :search do
      content { "what is" }
      user { "123.456.789" }
      count { 1 }
    end
  end
  