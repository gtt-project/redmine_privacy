module RedminePrivacy
  class PrivateUsername

    def initialize(user, project: nil)
      @user = user
      @project = project
    end

    def to_s
      memberships = @user.memberships
      if @project
        memberships = memberships.where(project: @project)
      end

      if m = memberships.first
        name = m.roles.first&.name
      end
      name || I18n.t(:label_user)
    end

  end
end
