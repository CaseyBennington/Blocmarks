FactoryGirl.define do
  factory :bookmark do
    url "http://google.com"
    user
    topic
  end
end
