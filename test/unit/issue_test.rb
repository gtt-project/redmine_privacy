require_relative '../test_helper'

class IssueTest < ActiveSupport::TestCase
  fixtures :projects

  setup do
    @project = Project.find 'ecookbook'
  end

  test 'should be private by default' do
    refute Issue.new(project: @project).is_private?
    @project.update_attribute :issues_private_by_default, true
    assert Issue.new(project: @project).is_private?
  end
end
