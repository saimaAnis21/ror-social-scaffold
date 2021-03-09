require 'rails_helper'

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = 'defined'
end

RSpec.describe Comment, type: :model do
    it 'is valid with a user_id, a post id, and a content' do
        user = User.create(name: 'Janet', email: 'janet@mail.com', password: '123456')
        post = Post.create(user_id:user.id, content:'aaaa')
        comment = Comment.create(post_id:post.id, user_id:user.id, content: 'aaaaaaaaaa')
        expect(comment).to be_valid
    end
end

RSpec.feature 'Users' do
    before(:each) do
      @user = User.create(name: 'user1', email: 'user1@mail.com', password: '123456')
      @user = User.create(name: 'user2', email: 'user2@mail.com', password: '123456')
      @post = Post.create(user_id:1, content:'aaaaaa')
      @frnd = Friendship.create(user_id:1,friend_id:2, status: 'true')
    end
  
    scenario 'user2 writes a comment' do
      
      visit root_path
      fill_in 'Email', with: 'user2@mail.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      click_on 'All users'
      page.find_by_id(1).click
      fill_in 'comment_content', with: 'This is a test comment!'
      click_on 'Comment'
      expect(page).to have_content 'This is a test comment!'
      sleep(10)
    end
  end