module RedminePrivacy
  module Patches
    module ProjectsControllerPatch

      def self.apply
        ProjectsController.prepend self unless ProjectsController < self
      end

      def show
        respond_to do |format|
          format.html {
            super
            # hide project members box if user is not allowed to view project members
            # users with Administrator privileges can always see the box
            unless User.current.allowed_to?(:view_project_members_info, @project)
              if Redmine::VERSION.to_s >= '4.2'
                @principals_by_role = []
              else
                @users_by_role = []
              end
            end
          }
          format.any { super }
        end
      end
    end
  end
end
