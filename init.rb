require 'redmine'

Rails.configuration.to_prepare do
  RedminePrivacy.setup
end

Redmine::Plugin.register :redmine_privacy do
  name 'Redmine Privacy Plugin'
  author 'Jens Krämer, Georepublic'
  author_url 'https://hub.georepublic.net/gtt/redmine_privacy'
  description 'Adds several privacy related options to Redmine'
  version '1.3.0'

  requires_redmine version_or_higher: '3.4.0'

  settings default: { }, partial: 'redmine_privacy/settings'

  project_module :privacy do

    # this permission allows users to see other users
    permission :view_users, {}, read: true

  end


end

