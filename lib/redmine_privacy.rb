module RedminePrivacy
  def self.setup
    RedminePrivacy::Patches::IssuePatch.apply
    RedminePrivacy::Patches::ProjectPatch.apply
    RedminePrivacy::Patches::PrincipalPatch.apply
    RedminePrivacy::Patches::UserPatch.apply

    RedminePrivacy::Patches::LinkToUserHelper.apply

    RedminePrivacy::Patches::IssuesControllerPatch.apply
    RedminePrivacy::Patches::ProjectsControllerPatch.apply
  end

  def self.possible_displayname_fallbacks
    User::USER_FORMATS
      .reject{|key, value| key == :displayname}
      .map{|key, value| [key, value[:setting_order]]}
      .sort{|a, b| a[1] <=> b[1]}
      .map{|f| [User.current.name(f[0]), f[0].to_s]}
  end

  def self.settings
    Setting.plugin_redmine_privacy
  end

  def self.displayname_fallback
    settings['displayname_fallback'].presence&.to_sym ||
      User::USER_FORMATS.keys.first
  end
end

require 'redmine_privacy/view_hooks'
