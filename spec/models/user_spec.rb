require 'rails_helper'

RSpec.describe User, type: :model do
  let(:alice) { User.create!(name: "alice", email: "alice@example.com", password: "test") }
  let(:bob) { User.create!(name: "bob", email: "bob@example.com", password: "test") }
  let(:carol) { User.create!(name: "carol", email: "carol@example.com", password: "test") }
  let(:eve) { User.create!(name: "eve", email: "eve@example.com", password: "test") }

  before do
    alice.friends << bob
    carol.friends << alice

    alice.chirps.create! content: "one"
    alice.chirps.create! content: "two"
    bob.chirps.create! content: "three"
    bob.chirps.create! content: "four"
    carol.chirps.create! content: "five"
    carol.chirps.create! content: "six"
    eve.chirps.create! content: "seven"
    eve.chirps.create! content: "eight"
  end

  describe "#following?" do
    it "knows who they are following" do
      expect(alice).to be_following(bob)
      expect(bob).not_to be_following(alice)

      expect(alice).not_to be_following(carol)
      expect(carol).to be_following(alice)

      expect(alice).not_to be_following(eve)
      expect(eve).not_to be_following(alice)

      expect(bob).not_to be_following(carol)
      expect(carol).not_to be_following(bob)
    end
  end

  describe "#timeline" do
    subject { alice.timeline.map(&:content) }

    it "includes own chirps" do
      expect(subject).to include("one")
      expect(subject).to include("two")
    end

    it "includes friends chirps" do
      expect(subject).to include("three")
      expect(subject).to include("four")
    end

    it "omits followers chirps" do
      expect(subject).not_to include("five")
      expect(subject).not_to include("six")
    end

    it "omits unrelated chirps" do
      expect(subject).not_to include("seven")
      expect(subject).not_to include("eight")
    end
  end
end
