require 'rails_helper'

RSpec.describe ListsController, type: :controller do
	let(:user) { FactoryGirl.create(:user) }

  describe "#new" do 
    context "with user not signed in" do 
      it "redirects to user sign up page" do 
        get :new 
        expect(response).to redirect_to(new_session_path)
      end
    end
    context "with user signed in" do 
      it "renders new template" do 
        u = FactoryGirl.create(:user)
        request.session[:user_id] = u.id 
        get :new 
        expect(response).to render_template(:new)
      end
      it "create a new list object assigned to 'list' instance variable" do 
        u = FactoryGirl.create(:user)
        request.session[:user_id] = u.id 
        get :new 
        expect(assigns(:list)).to be_a_new(List)
      end
    end
  end

  describe "#create" do 

    context "with no user signed in" do 
      it "redirect to sign up page" do 
        post :create, {list: {}}
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with user signed in" do 

    def valid_params 
      FactoryGirl.attributes_for(:list)
    end

    before do 
      request.session[:user_id] = user.id
    end

      context "with valid paramters" do 
        it "creates a list record in the database" do 
          before_count = List.count 
          post :create, list: valid_params
          after_count = List.count 
          expect(after_count - before_count).to eq(1)
        end
        it "associates the list with the signed in user" do 
          post :create, list: valid_params
          expect(List.last.user).to eq(user)
        end
        it "redirects to list show page" do 
          post :create, list: valid_params
          expect(response).to redirect_to(list_path(List.last))
        end
      end
      context "with invalid paramters" do 
        it "doesn't create a list record in the database" do 
          before_count =  List.count 
          post :create, list: valid_params.merge({title: nil})
          after_count = List.count
          expect(after_count - before_count).to eq(0)
        end
        it "renders the new template" do 
          post :create, list: valid_params.merge({title: nil})
          expect(response).to render_template(:new)
        end
      end
    end
  end
end