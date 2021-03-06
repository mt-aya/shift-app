require 'capybara/rspec'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    if ENV["SELENIUM_DRIVER_URL"].present?
      driven_by :selenium, using: :headless_chrome, options: {
        browser: :remote,
        url: ENV.fetch("SELENIUM_DRIVER_URL"),
        desired_capabilities: :chrome
      }
      Capybara.server_host = 'web'
      Capybara.app_host='http://web'
    else
      :selenium_chrome_headless
    end
  end
end