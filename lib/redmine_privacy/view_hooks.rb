module RedminePrivacy
  class ViewHooks < Redmine::Hook::ViewListener
    render_on :view_projects_form, partial: 'redmine_privacy/projects_form_hook'
    render_on :view_issues_new_top, partial: 'redmine_privacy/issues_new_top_hook'
    render_on :view_my_account_preferences, partial: 'redmine_privacy/my_account_hook'
  end
end
