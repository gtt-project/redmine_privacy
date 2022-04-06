require File.expand_path('../lib/redmine_privacy/view_hooks', __FILE__)

if Rails.version > '6.0' && Rails.autoloaders.zeitwerk_enabled?
  Rails.application.config.after_initialize do
    RedminePrivacy.setup
  end
else
  Rails.configuration.to_prepare do
    RedminePrivacy.setup
  end
end

Redmine::Plugin.register :redmine_privacy do
  name 'Redmine Privacy Plugin'
  author 'Jens Krämer, Georepublic'
  author_url 'https://github.com/georepublic'
  url 'https://github.com/gtt-project/redmine_privacy'
  description 'Adds several privacy related options to Redmine'
  version '1.3.2'

  requires_redmine version_or_higher: '3.4.0'

  settings default: { }, partial: 'redmine_privacy/settings'

  project_module :privacy do

    # this permission allows users to see other users
    permission :view_users, {}, read: true
    # this permission allows users to see same project member's displayname
    permission :view_members_displayname, {}, read: true

  end

end
