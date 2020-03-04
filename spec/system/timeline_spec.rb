require "rails_helper"

RSpec.describe "Timeline", type: :system do
  let(:alice) { User.create!(name: "alice", email: "alice@example.com", password: "secretstuff") }
  let(:bob) { User.create!(name: "bob", email: "bob@example.com", password: "opensesame") }

  before do
    login(as: alice)
  end

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
end
