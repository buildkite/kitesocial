require "rails_helper"

RSpec.describe "Timeline", type: :system, js: true do
  let(:alice) { User.create!(name: "alice", email: "alice@example.com", password: "secretstuff") }
  let(:bob) { User.create!(name: "bob", email: "bob@example.com", password: "opensesame") }
  let(:eve) { User.create!(name: "eve", email: "eve@example.com", password: "spyvsspy") }

  before do
    alice.friends << bob

    login(as: alice)
  end

  describe "default" do
    it "shows own chirps" do
      alice.chirps.create!(content: "test one")
      alice.chirps.create!(content: "test two")

      visit root_path

      expect(page).to have_text("test one")
      expect(page).to have_text("test two")
    end

    it "shows others' chirps" do
      bob.chirps.create!(content: "the best of times")
      bob.chirps.create!(content: "the worst of times")

      visit root_path

      expect(page).to have_text("the best of times")
      expect(page).to have_text("the worst of times")
    end

    it "only shows friends' chirps" do
      eve.chirps.create!(content: "things and stuff")

      visit root_path

      expect(page).to have_no_text("things and stuff")
    end

    it "shows mentions from strangers" do
      eve.chirps.create!(content: "things and stuff")
      eve.chirps.create!(content: "hey @alice! fancy seeing you here")

      visit root_path

      expect(page).to have_no_text("things and stuff")
      expect(page).to have_text("fancy seeing you here")
    end
  end

  describe "firehose" do
    it "shows own chirps" do
      alice.chirps.create!(content: "test one")
      alice.chirps.create!(content: "test two")

      visit firehose_path

      expect(page).to have_text("test one")
      expect(page).to have_text("test two")
    end

    it "shows others' chirps" do
      bob.chirps.create!(content: "the best of times")
      bob.chirps.create!(content: "the worst of times")

      visit firehose_path

      expect(page).to have_text("the best of times")
      expect(page).to have_text("the worst of times")
    end

    it "also shows unrelated people's chirps" do
      eve.chirps.create!(content: "things and stuff")

      visit firehose_path

      expect(page).to have_text("things and stuff")
    end
  end

  describe "user" do
    it "shows that user's chirps" do
      bob.chirps.create!(content: "the best of times")
      bob.chirps.create!(content: "the worst of times")

      visit user_path(bob)

      expect(page).to have_text("the best of times")
      expect(page).to have_text("the worst of times")
    end

    it "doesn't show anyone else's chirps" do
      alice.chirps.create!(content: "test one")
      alice.chirps.create!(content: "test two")
      eve.chirps.create!(content: "things and stuff")

      visit user_path(bob)

      expect(page).to have_no_text("test one")
      expect(page).to have_no_text("test two")
      expect(page).to have_no_text("things and stuff")
    end
  end
end
