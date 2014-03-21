require 'spec_helper'

describe Item do
  let(:item) { build(:item) }

  it 'has valid factory' do
    expect(item).to be_valid
  end

  context 'attributes' do
    it { should respond_to(:group_id) }
    it { should respond_to(:title) } 
    it { should respond_to(:priority) }
    it { should respond_to(:complete_on) }
    it { should respond_to(:completed) }
    it { should respond_to(:sort_order) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  context 'validations' do
    it { should validate_presence_of(:group_id) }
    it { should validate_presence_of(:title) }
  end

  context 'associations' do
    it { should belong_to(:group) }
  end
end
