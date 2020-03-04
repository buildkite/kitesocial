Capybara.configure do |config|
  config.server = :puma, { Silent: true }
end
