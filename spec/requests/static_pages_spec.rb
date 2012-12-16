require 'spec_helper'

describe "StaticPages" do
  describe "GET /home" do
    it "should have content 'Sample App'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit root_path
      page.should have_content('Sample App')
    end
  end

  describe "Help page" do
    
    it "" do
      visit help_path
      page.should have_content('help')
    end
  end
  describe "About page" do
    
    it "" do
      visit about_path
      page.should have_content('about')
    end
  end

  describe "Contact page" do
    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1',text: 'Contact')
    end

    it "should have title 'Contact'" do
      visit contact_path
      page.should have_selector('title',
                                text: "Contact")
    end
  end
end
