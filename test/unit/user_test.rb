require_relative '../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :email_addresses, :users

  setup do
    @user = User.find(2)
    @user.update_column :displayname, 'smitty'
  end

  test 'should mask out name for unprivileged user' do
    User.current = User.anonymous
    with_settings(user_format: 'firstname_lastname') do
      user = User.find @user.id
      assert_equal 'User', user.name
    end
  end

  test 'should format name' do
    User.current = User.find(1)

    with_settings(user_format: 'firstname_lastname') do
      user = User.find @user.id
      assert_equal 'John Smith', user.name
    end

    with_settings(user_format: 'displayname') do
      user = User.find @user.id
      assert_equal 'smitty', user.name
    end
  end

  test 'should use fallback format when necessary' do
    User.current = User.find(1)

    with_settings(
      user_format: 'firstname_lastname',
      plugin_redmine_privacy: { 'displayname_fallback' => 'login' }
    ) do
      user = User.find @user.id
      assert_equal 'John Smith', user.name
    end

    with_settings(
      user_format: 'displayname',
      plugin_redmine_privacy: { 'displayname_fallback' => 'username' }
    ) do
      assert_equal :username, RedminePrivacy.displayname_fallback

      user = User.find @user.id
      assert_equal 'smitty', user.name

      user = User.find @user.id
      user.update_column :displayname, ''
      assert_equal 'jsmith', user.name
    end

  end
end

