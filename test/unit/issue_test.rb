require_relative '../test_helper'

class IssueTest < ActiveSupport::TestCase

  test 'should be private by default' do
    refute RedminePrivacy.issues_private_by_default?
    refute Issue.new.is_private?

    with_settings plugin_redmine_privacy: { 'issues_private_by_default' => '1'} do
      assert RedminePrivacy.issues_private_by_default?
      assert Issue.new.is_private?
    end
  end
end
