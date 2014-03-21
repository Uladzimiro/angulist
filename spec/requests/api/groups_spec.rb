require 'spec_helper'

describe 'Groups API' do

  context 'not signed in' do
    describe 'GET /api/groups (#index)' do
      it '401 - Unauthorized' do
        get '/api/groups'
        expect(response.status).to eq(401)
        expect(json.keys).to eq(['error'])
        expect(json['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end

    describe 'GET /api/groups/1 (#show)' do
      it '401 - Unauthorized' do
        get '/api/groups/1'
        expect(response.status).to eq(401)
        expect(json.keys).to eq(['error'])
        expect(json['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end

    describe 'POST /api/groups (#create)' do
      it '401 - Unauthorized' do
        group = FactoryGirl.attributes_for(:group)
        post '/api/groups', { group: group }
        expect(response.status).to eq(401)
        expect(json.keys).to eq(['error'])
        expect(json['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end

    describe 'PATCH /api/groups/1 (#update)' do
      it '401 - Unauthorized' do
        group = FactoryGirl.create(:group)
        patch "/api/groups/#{group.id}", { group: group.attributes }
        expect(response.status).to eq(401)
        expect(json.keys).to eq(['error'])
        expect(json['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end
    
    describe 'DELETE /api/groups/1 (#destroy)' do
      it '401 - Unauthorized' do
        group = FactoryGirl.create(:group)
        delete "/api/groups/#{group.id}"
        expect(response.status).to eq(401)
        expect(json.keys).to eq(['error'])
        expect(json['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end
  end

end
