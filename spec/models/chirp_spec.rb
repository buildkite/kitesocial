require 'rails_helper'

RSpec.describe Chirp, type: :model do
  let!(:alice) { User.create!(name: "alice", email: "alice@example.com", password: "secretstuff") }
  let!(:bob) { User.create!(name: "bob", email: "bob@example.com", password: "opensesame") }
  let!(:carol) { User.create!(name: "carol", email: "carol@example.com", password: "christmas") }
  let!(:david) { User.create!(name: "david", email: "david@example.com", password: "statuesque") }
  let!(:eve) { User.create!(name: "eve", email: "eve@example.com", password: "spyvsspy") }

  before do
    alice.followers << bob
    alice.followers << carol
  end

  describe "mention tracking" do
    it "identifies mentioned users" do
      mention = alice.chirps.create!(content: "hey @bob")
      expect(mention.mentions).to match_array([bob])
    end

    it "deduplicates the user list" do
      mention = alice.chirps.create!(content: "hey @bob @bob @carol @bob @bob")
      expect(mention.mentions).to match_array([bob, carol])
    end

    it "avoids things that look like email addresses" do
      mention = alice.chirps.create!(content: "I just got a great email from tony@bob.com!")
      expect(mention.mentions).to be_empty
    end
  end

  describe "#interested_users" do
    let!(:chirp) { alice.chirps.create!(content: "#ff @carol @david") }

    it "includes the author" do
      expect(chirp.interested_users).to include(alice)
    end

    it "includes followers" do
      expect(chirp.interested_users).to include(bob)
      expect(chirp.interested_users).to include(carol)
    end

    it "includes mentions" do
      expect(chirp.interested_users).to include(carol)
      expect(chirp.interested_users).to include(david)
    end

    it "doesn't include unrelated users" do
      expect(chirp.interested_users).not_to include(eve)
    end

    it "doesn't contain duplicates" do
      expect(chirp.interested_users).to match_array([alice, bob, carol, david])
      expect(chirp.interested_users.size).to eq(4)
    end

    it "inverts as Chirp.timeline_for" do
      User.all.each do |user|
        if chirp.interested_users.include?(user)
          expect(Chirp.timeline_for(user)).to include(chirp)
        else
          expect(Chirp.timeline_for(user)).not_to include(chirp)
        end
      end
    end
  end
end
