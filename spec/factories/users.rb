FactoryGirl.define do
  factory :user do
    email {FFaker::Internet.free_email}
    encrypted_password {FFaker::Internet.password}
  end
end
