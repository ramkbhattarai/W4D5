require 'rails_helper.rb'

RSpec.describe User, type: :model do
  it {should validate_presence_of :username}
  it {should validate_presence_of :password_digest}
  it {should validate_presence_of :session_token}
  it {should validate_length_of(:password).is_at_least(6)}

  # it {should have_many(:goals)}
  # it {should have_many(:comments)}

  describe "uniqueness" do
    before(:each) do
      create(:user)
    end

    it {should validate_uniqueness_of(:session_token)}
    it {should validate_uniqueness_of(:username)}
  end

  describe "#is_password?" do 
    let! (:user) {create(:user)}
    context "with valid password" do 
      it "should return true" do 
        expect(user.is_password?("password")).to be(true)
      end
    end

    context "with invalid password" do 
      it "should return false" do 
        expect(user.is_password?("not_password")).to be(false)
      end
    end
  end

  describe "User::find_by_credentials" do
    let! (:user) {create(:user)}
    context "with valid credentials" do
      it "should return user" do
        expect(User.find_by_credentials(user.username, "password")).to eq(user)
      end
    end
    
    context "with invalid credentials" do
      it "should return nil" do
        expect(User.find_by_credentials(user.username, "not_password")).to eq(nil)
      end
    end
  end

  describe "#reset_session_token!" do
    let! (:user) {create(:user)}
    it "should reset user's session token" do
      old_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).not_to eq(old_token)
    end

    it "should return the user's session token" do
      expect(user.reset_session_token!).to eq(user.session_token)
    end
  end

end