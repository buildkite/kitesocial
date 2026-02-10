require "rails_helper"

RSpec.describe "Zeitwerk" do
  it "eager loads all files without errors" do
    expect { Rails.autoloaders.main.eager_load(force: true) }.not_to raise_error
  end
end
