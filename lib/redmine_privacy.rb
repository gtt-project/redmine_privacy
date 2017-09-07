module RedminePrivacy
  def self.setup
    ::RedminePrivacy::Patches::IssuePatch.apply
  end

  def self.settings
    Setting.plugin_redmine_privacy
  end

  def self.issues_private_by_default?
    !!settings['issues_private_by_default']
  end

end
