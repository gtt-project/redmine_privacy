module RedminePrivacy
  def self.setup
    RedminePrivacy::Patches::IssuePatch.apply
    RedminePrivacy::Patches::ProjectPatch.apply
  end
end

require 'redmine_privacy/view_hooks'
