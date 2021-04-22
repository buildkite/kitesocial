require 'rails_helper'

RSpec.describe ChirpPresenter, type: :presenter do
  let!(:alice) { User.create!(name: "alice", email: "alice@example.com", password: "secretstuff") }
  let!(:bob) { User.create!(name: "bob", email: "bob@example.com", password: "opensesame") }
  let!(:carol) { User.create!(name: "carol", email: "carol@example.com", password: "christmas") }

  before do
    alice.followers << bob
  end

  describe "#to_hash" do
    it "formats a chirp in a suitable format for use as JSON" do
      mention = alice.chirps.create!(content: "hey @bob @bob @carol @bob @bob")

      chirp_data = ChirpPresenter.to_hash(mention)
      expect(chirp_data).to match({
        author: { id: alice.id,
                  name: alice.name,
                  url: "/users/#{alice.id}" },
        content: mention.content,
        created_at: mention.created_at.rfc3339,
        mentions: [
          { id: bob.id,
            name: bob.name,
            url: "/users/#{bob.id}" },
          { id: carol.id,
            name: carol.name,
            url: "/users/#{carol.id}" }
        ],
        updated_at: mention.updated_at.rfc3339,
      })
    end
  end
end
