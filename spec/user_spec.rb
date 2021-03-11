require 'rails_helper'

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = 'defined'
end

RSpec.describe 'User', type: :model do
  it 'is valid with a username, an email and password' do
    user = User.create(name: 'Janet', email: 'janet@mail.com', password: '123456')
    expect(user).to be_valid
  end

  it 'is not valid with only username' do
    user = User.create(name: 'James')
    expect(user).to_not be_valid
  end

  it 'is not valid with only email' do
    user = User.create(email: 'roses@mail.com')
    expect(user).to_not be_valid
  end
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

RSpec.feature 'Users' do
  before(:each) do
    @user = User.create(name: 'user1', email: 'user1@mail.com', password: '123456')
    @user = User.create(name: 'user2', email: 'user2@mail.com', password: '123456')
  end

  scenario 'user1 sends friendship request and user2 accepts the request' do
    visit root_path
    fill_in 'Email', with: 'user1@mail.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    expect(current_path).to eql(root_path)
    click_on 'All users'
    sleep(15)
    first(:button, "Request Friendship").click
    #click_on 'Request Friendship'
    sleep(5)
    expect(page).to have_current_path('/users/1')
    expect(page).to have_content 'user2'
    click_on 'Sign out'

    fill_in 'Email', with: 'user2@mail.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    expect(current_path).to eql(root_path)
    click_on 'All users'
    page.find_by_id(2).click
    click_on 'Accept'
    expect(page).to have_current_path('/users/2')
    sleep(5)
    expect(page).to have_content 'user1'
  end
end
