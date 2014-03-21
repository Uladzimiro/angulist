require 'spec_helper'

describe Group do
  let(:group) { build(:group) }

  it 'has valid factory' do
    expect(group).to be_valid
  end

  context 'attributes' do
    it { should respond_to(:user_id) }
    it { should respond_to(:title) } 
    it { should respond_to(:sort_order) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  context 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:title) }
  end

  context 'associations' do
    it { should belong_to(:user) }
  end
end
