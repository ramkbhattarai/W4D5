require "rails_helper.rb"

RSpec.describe UsersController, type: :controller do
  describe "get#index" do
      it "should render users index" do 
        get(:index)
        expect(response).to render_template(:index)
      end
  end

   describe "get#show" do
    before(:each) do 
        create(:user)
    end
    context "when user exists" do
      it "should render users show" do 
          get(:show, params: {id: User.last})
          expect(response).to render_template(:show)
      end
    end
    
    context "when user does not exist" do
      it "should raise an error" do
        get(:show, params: {id: 100})
        expect(flash[:errors]).to eq(["Invalid User"])
      end

      it "should redirect to index page" do
        get(:show, params: {id: 100})
        expect(response).to redirect_to(users_url)
      end
    end
  end

   describe "get#new" do
    it "should render the new template" do
      allow(subject).to receive(:logged_in?).and_return(true)
      get(:new)
      expect(response).to render_template(:new)
    end
  end

   describe "post#create" do
      context "with valid parameters" do 
        it "should redirect to get#show" do 
          post(:create, params: {user: {username: "alex", password: "password"}})

          expect(response).to redirect_to(user_url(User.last.id))
        end
      end

      context "with invalid parameters" do 
          it "should render to get#new" do 
          post(:create, params: {user: {username: "alex", password: "word"}})

          expect(response).to render_template(:new)
        end
      end
  end


end