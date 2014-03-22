require 'spec_helper'

describe 'Items API' do
  context 'signed in' do
    let(:user) { create(:user) } 
    before { login_as(user, scope: :user) }
    after { Warden.test_reset! }

    describe 'GET /api/items (#index)' do
      let(:group1) { create(:group, user: user) }
      let(:group2) { create(:group, user: user) }
      let(:group3) { create(:group, user: create(:user)) }
      before do
        create_list(:item, 1, group: group1)
        create_list(:item, 2, group: group2)
        create_list(:item, 4, group: group3)
      end
      
      context 'all items' do
        it '200 - Success (returns all items of a user' do
          get '/api/items'
          expect(response.status).to eq(200)
          expect(json).to be_kind_of(Array)
          expect(json.length).to eq(3)
          expect(json[0].keys).to match_array(['id', 'group_id', 'title', 'priority', 'complete_on', 'completed', 'sort_order', 'created_at']) 
        end
      end

      context 'items for our category' do
        it '200 - Success (returns items of a group' do
          get "/api/items", group_id: group2.id
          expect(response.status).to eq(200)
          expect(json).to be_kind_of(Array)
          expect(json.length).to eq(2)
          expect(json[0].keys).to match_array(['id', 'group_id', 'title', 'priority', 'complete_on', 'completed', 'sort_order', 'created_at']) 
        end
      end
      
      context 'items for not our category' do
        it '200 - Success (returns items of a group' do
          get "/api/items", group_id: group3.id
          expect(response.status).to eq(200)
          expect(json).to be_kind_of(Array)
          expect(json.length).to eq(0)
        end
      end
    end

    describe 'GET /api/items/1 (#show)' do
      let(:group1) { create(:group, user: user) }
      let(:group2) { create(:group, user: create(:user)) }
      let(:item1) { create(:item, group: group1) }
      let(:item2) { create(:item, group: group2) }
                            
      context 'our item' do
        it '200 - Success' do
          get "/api/items/#{item1.id}"
          expect(response.status).to eq(200)
          expect(json).to be_kind_of(Hash)
          expect(json.keys).to match_array(['id', 'group_id', 'title', 'priority', 'complete_on', 'completed', 'sort_order', 'created_at']) 
          expect(json['id']).to eq(item1.id)
          expect(json['group_id']).to eq(item1.group_id)
          expect(json['title']).to eq(item1.title)
          expect(json['priority']).to eq(item1.priority)
          expect(Date.parse(json['complete_on'])).to eq(item1.complete_on)
          expect(json['completed']).to eq(item1.completed)
          expect(json['sort_order']).to eq(item1.sort_order)
          expect(DateTime.parse(json['created_at']).to_i).to eq(item1.created_at.to_i)
        end
      end

      context 'not our item' do
        it '404 - Not Found' do
          get "/api/items/#{item2.id}"
          expect(response.status).to eq(404)
          expect(json.keys).to match_array(['error']) 
          expect(json['error']).to eq('Not Found')
        end
      end
    end

    describe 'POST /api/groups (#create)' do
      it '201 - Created' do
        group = create(:group, user: user)
        post '/api/items', item: attributes_for(:item, group_id: group.id)
        expect(response.status).to eq(201)
        expect(json).to be_a_kind_of(Hash)
        expect(json.keys).to match_array(['id', 'group_id', 'title', 'priority', 'complete_on', 'completed', 'sort_order', 'created_at'])

        item = Item.reorder(:created_at).last
        expect(json['id']).to eq(item.id)
        expect(json['group_id']).to eq(item.group_id)
        expect(json['title']).to eq(item.title)
        expect(json['priority']).to eq(item.priority)
        expect(Date.parse(json['complete_on'])).to eq(item.complete_on)
        expect(json['completed']).to eq(item.completed)
        expect(json['sort_order']).to eq(item.sort_order)
        expect(DateTime.parse(json['created_at']).to_i).to eq(item.created_at.to_i)
      end
    end

    describe 'PATCH /api/groups/1 (#update)' do
      let(:group1) { create(:group, user: user) }
      let(:group2) { create(:group, user: create(:user)) }
      let(:item1) { create(:item, group: group1) }
      let(:item2) { create(:item, group: group2) }

      
      context 'our item' do
        it '204 - No Content (Successfully updated)' do
          new_attributes = {title: 'New Title', priority: 55, complete_on: '2015-01-01', completed: true, sort_order: 999}
          patch "/api/items/#{item1.id}", item: new_attributes
          expect(response.status).to eq(204)

          updated_item = Item.find(item1.id)
          expect(updated_item.id).to eq(item1.id)
          expect(updated_item.group_id).to eq(item1.group_id)
          expect(updated_item.title).to eq(new_attributes[:title])
          expect(updated_item.priority).to eq(new_attributes[:priority])
          expect(updated_item.complete_on).to eq(Date.parse(new_attributes[:complete_on]))
          expect(updated_item.completed).to eq(new_attributes[:completed])
          expect(updated_item.sort_order).to eq(new_attributes[:sort_order])
        end

        it 'does not changes group to group of someone else' do
          pending 'have no time for this case'
        end
      end

      context 'not our item' do
        it '404 - Not Found' do
          new_attributes = {title: 'New Title', priority: 55, complete_on: '2015-01-01', completed: true, sort_order: 999}
          patch "/api/items/#{item2.id}", item: new_attributes

          expect(response.status).to eq(404)
          expect(json.keys).to eq(['error'])
          expect(json['error']).to eq('Not Found')

          updated_item = Item.find(item2.id)
          expect(updated_item.id).to eq(item2.id)
          expect(updated_item.group_id).to eq(item2.group_id)
          expect(updated_item.title).not_to eq(new_attributes[:title])
          expect(updated_item.priority).not_to eq(new_attributes[:priority])
          expect(updated_item.complete_on).not_to eq(Date.parse(new_attributes[:complete_on]))
          expect(updated_item.completed).not_to eq(new_attributes[:completed])
          expect(updated_item.sort_order).not_to eq(new_attributes[:sort_order])
        end
      end
    end

    describe 'DELETE /api/items/1 (#destroy)' do
      let(:group1) { create(:group, user: user) }
      let(:group2) { create(:group, user: create(:user)) }
      let(:item1) { create(:item, group: group1) }
      let(:item2) { create(:item, group: group2) }

      context 'our item' do
        it '204 - No Content (Successfully deleted)' do
          delete "/api/items/#{item1.id}"
          expect(response.status).to eq(204)
          expect(Item.where(id: item1.id).count).to eq(0)
        end
      end

      context 'not our item' do
        it '404 - Not Found' do
          delete "/api/items/#{item2.id}"
          expect(response.status).to eq(404)
          expect(Item.where(id: item2.id).count).to eq(1)
        end
      end
    end
  end

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
