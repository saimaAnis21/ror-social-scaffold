require 'rails_helper'

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = 'defined'
end

RSpec.describe Post, type: :model do
  it 'is valid with a content and a user_id' do
    user = User.create(name:'Sam', email:'sam@sample.com', password:'123456')
    post = Post.create(user_id: user.id, content: 'aaaaaa')
    expect(post).to be_valid
  end
end
