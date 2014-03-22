require 'spec_helper'

describe HomeController do
  let(:user) { create(:user) }

  describe "GET 'index'" do
    context 'signed_in_user' do
      before { sign_in(user) }

      it "redirects to groups#index" do
        get :index
        response.should redirect_to(groups_path)
      end
    end

    context 'not signed in user' do
      it 'renders #index' do
        get :index 
        response.should be_ok
        response.should render_template('index')
      end
    end
  end
end
