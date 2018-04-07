require_relative '../test_helper'

class RedminePrivacyTest < ActiveSupport::TestCase

  setup do
  end

  test 'should store settings' do
    with_settings(
      user_format: 'displayname',
      plugin_redmine_privacy: { 'displayname_fallback' => 'username' }
    ) do
      assert_equal :displayname, Setting.user_format
      assert_equal :username, RedminePrivacy.displayname_fallback
    end
  end

  test 'fallbacks should not include displayname' do
    formats = RedminePrivacy.possible_displayname_fallbacks.map(&:last)
    assert formats.include?('username'), formats.inspect
    refute formats.include?('displayname')
  end

end


