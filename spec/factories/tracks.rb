FactoryGirl.define do
  factory :track do
    sequence(:track_id) { |n| "newtrack#{n}" }
    metadata { 'testmetadata' }
  end
end
