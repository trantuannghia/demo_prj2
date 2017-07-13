require "rails_helper"

RSpec.describe Comment, type: :model do
  context "association" do
    it {is_expected.to belong_to :post}
  end

  context "validates" do
    it {expect :content}
    it {expect :user_id}
    it {expect :post_id}
  end

end
