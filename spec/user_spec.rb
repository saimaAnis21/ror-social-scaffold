require 'rails_helper'

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = 'defined'
end

describe 'associations' do
  it 'should have many friends' do
    t = User.reflect_on_association(:friendships)
    expect(t.macro).to eq(:has_many)
  end

  it 'should have many friends' do
    t = User.reflect_on_association(:inverse_friendships)
    expect(t.macro).to eq(:has_many)
  end
end
