require "rails_helper"

RSpec.feature "Login", :js do
  let!(:user) { User.create!(email: "test@example.com", password: "test") }

  context "without a current user" do
    it "redirects from home to login" do
      visit root_path

      expect(page).to have_button("Log in")
    end

    it "accepts a valid password" do
      visit new_session_path

      fill_in "email", with: "test@example.com"
      fill_in "password", with: "test"
      click_button "Log in"

      expect(page).to have_no_button("Log in")
      expect(page).to have_button("Log out")
    end

    it "refuses an invalid password" do
      visit new_session_path

      fill_in "email", with: "test@example.com"
      fill_in "password", with: "wrong"
      click_button "Log in"

      expect(page).to have_text("Unknown email")

      expect(page).to have_button("Log in")
      expect(page).to have_no_button("Log out")
    end
  end

  context "with a current user" do
    before do
      login
    end

    def login
      visit new_session_path

      fill_in "email", with: "test@example.com"
      fill_in "password", with: "test"
      click_button "Log in"

      expect(page).to have_no_button("Log in")
    end

    it "logs out" do
      click_button "Log out"

      expect(page).to have_button("Log in")
      expect(page).to have_no_button("Log out")

      visit root_path

      # Still logged out
      expect(page).to have_button("Log in")
      expect(page).to have_no_button("Log out")
    end
  end
end
