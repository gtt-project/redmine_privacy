module RedminePrivacy
  def self.setup
    RedminePrivacy::Patches::IssuePatch.apply
    RedminePrivacy::Patches::ProjectPatch.apply
    RedminePrivacy::Patches::PrincipalPatch.apply
    RedminePrivacy::Patches::UserPatch.apply

    RedminePrivacy::Patches::LinkToUserHelper.apply

    RedminePrivacy::Patches::ProjectsControllerPatch.apply
  end
end

require 'redmine_privacy/view_hooks'
