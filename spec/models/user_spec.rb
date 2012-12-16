# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  
  before { @user = User.new(name: "Test User", email: "email@email.com",
                            password: "jdpjdp", password_confirmation: "jdpjdp")}

  subject { @user }

  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:token)}
  it { should respond_to(:authenticate)}

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = "" }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when password is less than six characters long" do
    before { @user.password=@user.password_confirmation= "a"*5 }
    it { should be_invalid }
  end

  describe "when password dosen't match password_confirmation" do
    before { @user.password=@user.password_confirmation= "" }
    it { should_not be_valid }
  end

  describe "when password_confirmation is nil" do
    before { @user.password_confirmation= nil }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) {User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should== found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_invalid_password) { found_user.authenticate("invalid")}

      it {should_not == user_invalid_password }
      specify { user_invalid_password.should be_false }
    end
  end

  describe "token" do
    before { @user.save }
    its(:token) { should_not be_blank }
  end
end
