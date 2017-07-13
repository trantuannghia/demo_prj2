require "rails_helper"

RSpec.describe PostTag, type: :model do
  context "association" do
    it {is_expected.to belong_to :tag}
    it {is_expected.to belong_to :post}
  end

  context "validates" do
    it {expect :post_id}
    it {expect :tag_id}
  end

end
