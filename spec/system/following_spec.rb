require "rails_helper"

RSpec.describe "Following", type: :system do
  let(:alice) { User.create!(name: "alice", email: "alice@example.com", password: "secretstuff") }
  let(:bob) { User.create!(name: "bob", email: "bob@example.com", password: "opensesame") }
  let(:eve) { User.create!(name: "eve", email: "eve@example.com", password: "spyvsspy") }

  before do
    login(as: alice)
  end

  describe "follow" do
    it "records the follow" do
      visit user_path(bob)

      click_button "Follow"

      expect(alice).to be_following(bob)
    end
  end

  describe "unfollow" do
    before do
      alice.friends << bob
    end

    it "destroys the follow" do
      visit user_path(bob)

      click_button "Unfollow"

      expect(alice).not_to be_following(bob)
    end
  end
end
