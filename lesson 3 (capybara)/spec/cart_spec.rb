require 'capybara/rspec'
require 'selenium-webdriver'

Capybara.default_driver = :selenium_chrome
Capybara.save_path = 'screenshots'

RSpec.configure do |config|
  config.after do |example|
    if example.exception
      timestamp = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
      screenshot_path = "screenshots/screenshot-#{timestamp}-#{example.full_description}.png"
      page.save_screenshot(screenshot_path)
      puts "Screenshot saved at #{screenshot_path}"
    end
  end
end

RSpec.describe 'Sauce Demo', type: :feature do
  before(:each) do
    visit 'https://www.saucedemo.com'
  end

  it 'adds two items to the cart' do
    fill_in 'user-name', with: 'standard_user'
    fill_in 'password', with: 'secret_sauce'
    click_button 'Login'
    first('.inventory_item').find('button').click
    first('.inventory_item:nth-child(2)').find('button').click
    find('a.shopping_cart_link').click
    expect(page).to have_content('2')
    save_screenshot('items_added_to_cart')
  end

  it 'fails login for error_user' do
    fill_in 'user-name', with: 'error_user'
    fill_in 'password', with: 'secret_sauce'
    click_button 'Login'
    expect(page).to have_text('Epic sadface: Username and password do not match any user in this service')
    save_screenshot('error_user_login_failed')
  end

  it 'fails login for locked_out_user' do
    fill_in 'user-name', with: 'locked_out_user'
    fill_in 'password', with: 'secret_sauce'
    click_button 'Login'
    expect(page).to have_text('Epic sadface: Sorry, this user has been locked out.')
    save_screenshot('locked_out_user_login_failed')
  end
end