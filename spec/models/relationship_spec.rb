require "rails_helper"

RSpec.describe Relationship, type: :model do
  context "association" do
    it {is_expected.to belong_to :follower}
    it {is_expected.to belong_to :followed}
  end

  context "validates" do
    it {expect :follower_id}
    it {expect :followed_id}
  end

end