require "capybara-screenshot"
require "capybara-inline-screenshot/rspec"

Capybara.configure do |config|
  config.default_driver = :rack_test
  config.javascript_driver = :selenium

  config.server = :puma, { Silent: true }

  unless system("which", "chromedriver", out: :close, err: :close)
    puts "Warning: chromedriver not found. You may need to install chromedriver."
    puts "\nTry: brew install chromedriver" if RUBY_PLATFORM =~ /darwin/
  end

  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new app,
      browser: :chrome,
      desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
        # macOS inherits display's dpi causing odd screenshots so force a scale factor
        chromeOptions: { args: %w[--headless --disable-gpu --force-device-scale-factor=1 --window-size=1400,900] }
      )
  end

  config.save_path = Rails.root.join("tmp/capybara")
end
