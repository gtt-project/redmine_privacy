require_relative '../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :email_addresses, :users, :roles, :projects, :members, :member_roles

  setup do
    @user = User.find(3)
    @user.update_column :displayname, 'davie'
  end

  test 'should mask out name for unprivileged user' do
    User.current = User.anonymous
    with_settings(user_format: 'firstname_lastname') do
      user = User.find @user.id
      assert_equal 'Developer', user.name
    end
  end

  test 'should format name' do
    User.current = User.find(1)

    with_settings(user_format: 'firstname_lastname') do
      user = User.find @user.id
      assert_equal 'Dave Lopper', user.name
    end

    with_settings(user_format: 'displayname') do
      user = User.find @user.id
      assert_equal 'davie', user.name
    end
  end

  test 'should use fallback format when necessary' do
    User.current = User.find(1)

    with_settings(
      user_format: 'firstname_lastname',
      plugin_redmine_privacy: { 'displayname_fallback' => 'login' }
    ) do
      user = User.find @user.id
      assert_equal 'Dave Lopper', user.name
    end

    with_settings(
      user_format: 'displayname',
      plugin_redmine_privacy: { 'displayname_fallback' => 'username' }
    ) do
      assert_equal :username, RedminePrivacy.displayname_fallback

      user = User.find @user.id
      assert_equal 'davie', user.name

      user = User.find @user.id
      user.update_column :displayname, ''
      assert_equal 'dlopper', user.name
    end
  end

  test 'should show display name (or role name as fallback) of same project member with permission' do
    Role.find(1).add_permission! :view_members_displayname
    User.current = User.find(2)
    with_settings(user_format: 'firstname_lastname') do
      user = User.find @user.id
      assert_equal 'davie', user.name

      user = User.find @user.id
      user.update_column :displayname, ''
      assert_equal 'Developer', user.name
    end
  end

  test 'should not show display name of same project member without permission' do
    Role.find(1).remove_permission! :view_members_displayname
    User.current = User.find(2)
    with_settings(user_format: 'firstname_lastname') do
      user = User.find @user.id
      assert_equal 'Developer', user.name
    end
  end

  test 'should not show display name of another project member with permission' do
    Role.find(2).add_permission! :view_members_displayname
    User.current = User.find(8)
    with_settings(user_format: 'firstname_lastname') do
      user = User.find @user.id
      assert_equal 'Developer', user.name
    end
  end

end

