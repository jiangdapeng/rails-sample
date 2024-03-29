require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',text: user.name) }
    it { should have_selector('title',text:user.name )}
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',text: 'Sign up')}
    it { should have_selector('title',text: full_title('Sign up'))}
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User,:count)
      end
    end

    describe "valid information" do
      before do
        fill_in "Name", with: "DapengJiang"
        fill_in "Email", with: "jdpdyx@126.com"
        fill_in "Password", with: "longlong"
        fill_in "Confirmation", with: "longlong"
      end

      it "create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
