module RedminePrivacy
  class PrivateUsername

    def initialize(user, project: nil)
      @user = user
      @project = project
    end

    def to_s
      memberships = @user.memberships
      current_user_memberships = User.current.memberships
      if @project
        memberships = memberships.where(project: @project)
        current_user_memberships = current_user_memberships.where(project: @project)
      else
        project_ids = memberships.map {|m| m.project_id}
        current_user_memberships = current_user_memberships.where(project: project_ids)
      end

      name = nil
      if m = memberships.first
        if current_user_memberships.exists? \
          && User.current.allowed_to?(:view_members_displayname, nil, global: true)
          name = @user.displayname
        end
        if name.blank?
          name = m.roles.first&.name
        end
      end
      name || I18n.t(:label_user)
    end

  end
end
