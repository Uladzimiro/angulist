require 'spec_helper'

describe 'Items API' do

  context 'not signed in' do
    describe 'GET /api/items (#index)' do
      it '401 - Unauthorized' do
        get '/api/items'
        expect(response.status).to eq(401)
        expect(json.keys).to eq(['error'])
        expect(json['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end

    describe 'GET /api/items/1 (#show)' do
      it '401 - Unauthorized' do
        get '/api/items/1'
        expect(response.status).to eq(401)
        expect(json.keys).to eq(['error'])
        expect(json['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end

    describe 'POST /api/items (#create)' do
      it '401 - Unauthorized' do
        item = FactoryGirl.attributes_for(:item)
        post '/api/items', { item: item }
        expect(response.status).to eq(401)
        expect(json.keys).to eq(['error'])
        expect(json['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end

    describe 'PATCH /api/items/1 (#update)' do
      it '401 - Unauthorized' do
        item = FactoryGirl.create(:item)
        patch "/api/items/#{item.id}", { item: item.attributes }
        expect(response.status).to eq(401)
        expect(json.keys).to eq(['error'])
        expect(json['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end
    
    describe 'DELETE /api/items/1 (#destroy)' do
      it '401 - Unauthorized' do
        item = FactoryGirl.create(:item)
        delete "/api/items/#{item.id}"
        expect(response.status).to eq(401)
        expect(json.keys).to eq(['error'])
        expect(json['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end
  end

end
