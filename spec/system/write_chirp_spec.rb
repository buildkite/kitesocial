require "rails_helper"

RSpec.describe "Write chirp", type: :system do
  before do
    login
  end

  it "posts a new chirp via turbo stream without a page reload" do
    visit root_path

    page.execute_script("document.body.dataset.noReload = 'true'")

    fill_in "chirp_content", with: "Hello world"
    click_button "Chirp!"

    expect(page).to have_text("Hello world")
    expect(page.evaluate_script("document.body.dataset.noReload")).to eq("true")
  end

  it "clears the form after posting" do
    visit root_path

    fill_in "chirp_content", with: "Hello world"
    click_button "Chirp!"

    expect(page).to have_text("Hello world")
    expect(find_field("chirp_content").value).to eq("")
  end

  it "persists multiple chirps" do
    visit root_path

    fill_in "chirp_content", with: "Hello world"
    click_button "Chirp!"

    fill_in "chirp_content", with: "More content here"
    click_button "Chirp!"

    expect(page).to have_text("Hello world")
    expect(page).to have_text("More content here")
  end
end
