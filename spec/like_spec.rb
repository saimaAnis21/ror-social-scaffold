require 'rails_helper'

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = 'defined'
end

RSpec.describe Like, type: :model do
  it 'is valid with a content and a user_id' do
    user = User.create(name: 'Janet', email: 'janet@mail.com', password: '123456')
    post = Post.create(user_id: user.id, content: 'aaaa')
    like = Like.create(post_id: post.id, user_id: user.id)
    expect(like).to be_valid
  end

  it 'is unique with a content and a user_id' do
    user = User.create(name: 'Janet', email: 'janet@mail.com', password: '123456')
    post = Post.create(user_id: user.id, content: 'aaaa')
    Like.create(post_id: post.id, user_id: user.id)
    like_same = Like.create(post_id: post.id, user_id: user.id)
    expect(like_same).not_to be_valid
  end
end
