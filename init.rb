require 'redmine'

Rails.configuration.to_prepare do
  RedminePrivacy.setup
end

Redmine::Plugin.register :redmine_privacy do
  name 'Redmine Privacy Plugin'
  author 'Jens Krämer, Georepublic'
  author_url 'https://hub.georepublic.net/gtt/redmine_privacy'
  description 'Adds several privacy related options to Redmine'
  version '0.1.0'

  requires_redmine version_or_higher: '3.4.0'

  project_module :privacy do

    permission :view_user_names, {}, read: true
    permission :view_user_pages, { users: %i( show ) }, read: true

  end


end

