require 'spec_helper'

describe 'Groups API' do
  context 'signed in' do
    let(:user) { create(:user) } 
    before { login_as(user, scope: :user) }
    after { Warden.test_reset! }

    describe 'GET /api/groups (#index)' do
      it '200 - Success' do
        create_list(:group, 2, user: user)
        create(:group, user: create(:user))
        get '/api/groups'
        expect(response.status).to eq(200)
        expect(json).to be_kind_of(Array)
        expect(json.length).to eq(2)
        expect(json[0].keys).to match_array(['id', 'title', 'sort_order', 'created_at']) 
      end
    end

    describe 'GET /api/groups/1 (#show)' do
      context 'our group' do
        it '200 - Success' do
          group = create(:group, user: user)
          get "/api/groups/#{group.id}"
          expect(response.status).to eq(200)
          expect(json).to be_kind_of(Hash)
          expect(json.keys).to match_array(['id', 'title', 'sort_order', 'created_at']) 
          expect(json['id']).to eq(group.id)
          expect(json['title']).to eq(group.title)
          expect(json['sort_order']).to eq(group.sort_order)
          expect(DateTime.parse(json['created_at']).to_i).to eq(group.created_at.to_i)
        end
      end

      context 'not our group' do
        it '404 - Not Found' do
          group = create(:group, user: create(:user))
          get "/api/groups/#{group.id}"
          expect(response.status).to eq(404)
          expect(json.keys).to match_array(['error']) 
          expect(json['error']).to eq('Not Found')
        end
      end
    end

    describe 'POST /api/groups (#create)' do
      it '201 - Created' do
        post '/api/groups', group: attributes_for(:group, user_id: nil)
        expect(response.status).to eq(201)
        expect(json).to be_a_kind_of(Hash)
        expect(json.keys).to match_array(['id', 'title', 'sort_order', 'created_at'])

        group = Group.reorder(:created_at).last
        expect(json['id']).to eq(group.id)
        expect(json['title']).to eq(group.title)
        expect(json['sort_order']).to eq(group.sort_order)
        expect(DateTime.parse(json['created_at']).to_i).to eq(group.created_at.to_i)
      end
    end

    describe 'PATCH /api/groups/1 (#update)' do
      context 'our group' do
        it '204 - No Content (Successfully updated)' do
          group = create(:group, user: user)
          new_attributes = {title: 'New Title', sort_order: 999}
          patch "/api/groups/#{group.id}", group: new_attributes
          expect(response.status).to eq(204)

          updated_group = Group.find(group.id)
          expect(updated_group.id).to eq(group.id)
          expect(updated_group.title).to eq(new_attributes[:title])
          expect(updated_group.sort_order).to eq(new_attributes[:sort_order])
          expect(updated_group.created_at.to_i).to eq(group.created_at.to_i)
        end
      end

      context 'not our group' do
        it '404 - Not Found' do
          group = create(:group, user: create(:user))
          new_attributes = {title: 'New Title', sort_order: 999}
          patch "/api/groups/#{group.id}", group: new_attributes

          expect(response.status).to eq(404)
          expect(json.keys).to eq(['error'])
          expect(json['error']).to eq('Not Found')

          updated_group = Group.find(group.id)
          expect(updated_group.id).to eq(group.id)
          expect(updated_group.title).to eq(group.title)
          expect(updated_group.sort_order).to eq(group.sort_order)
          expect(updated_group.created_at.to_i).to eq(group.created_at.to_i)
        end
      end
    end

    describe 'DELETE /api/groups/1 (#destroy)' do
      context 'our group' do
        it '204 - No Content (Successfully deleted)' do
          group = create(:group, user: user)
          delete "/api/groups/#{group.id}"
          expect(response.status).to eq(204)
          expect(Group.where(id: group.id).count).to eq(0)
        end
      end

      context 'not our group' do
        it '404 - Not Found' do
          group = create(:group, user: create(:user))
          delete "/api/groups/#{group.id}"
          expect(response.status).to eq(404)
          expect(Group.where(id: group.id).count).to eq(1)
        end
      end
    end
  end

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
        post '/api/groups', { group: attributes_for(:group) }
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
