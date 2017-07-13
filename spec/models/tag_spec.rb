require "rails_helper"

RSpec.describe Tag, type: :model do
  context "association" do
    it {expect have_many :post_tags}
  end

  context "validates" do
    it {expect :name}
  end

end
