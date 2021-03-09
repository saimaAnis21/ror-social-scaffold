require 'rails_helper'

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = 'defined'
end

RSpec.describe Post, type: :model do
  it 'is valid with a content and a user_id' do
    post = Post.create(user_id: 1, content: 'aaaaaa')
    expect(post).to be_valid
  end
end
