module LoginHelper
  def default_user
    @default_user ||= User.create!(name: "test", email: "test@example.com", password: "test")
  end

  def login(as: default_user)
    visit new_session_path

    fill_in "email", with: as.email
    fill_in "password", with: as.password
    click_button "Log in"

    expect(page).to have_button("Log out")
    expect(page).to have_no_button("Log in")
  end
end

RSpec.configure do |config|
  config.include LoginHelper, type: :system
end
