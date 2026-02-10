require "rails_helper"

RSpec.describe "Following", type: :system do
  let(:alice) { User.create!(name: "alice", email: "alice@example.com", password: "secretstuff") }
  let(:bob) { User.create!(name: "bob", email: "bob@example.com", password: "secretstuff") }
  let(:eve) { User.create!(name: "eve", email: "eve@example.com", password: "secretstuff") }

  before do
    login(as: alice)
  end

  describe "follow" do
    it "records the follow" do
      visit user_path(bob)

      click_button "Follow"

      expect(page).to have_button("Unfollow")
      expect(alice.reload).to be_following(bob)
    end
  end

  describe "unfollow" do
    before do
      alice.friends << bob
    end

    it "destroys the follow" do
      visit user_path(bob)

      click_button "Unfollow"

      expect(page).to have_button("Follow")
      expect(alice.reload).not_to be_following(bob)
    end
  end
end
