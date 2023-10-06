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
            # having no users effectively hides the project members box
            if Redmine::VERSION.to_s >= '4.2'
              @principals_by_role = []
            else
              @users_by_role = []
            end
          }
          format.any { super }
        end
      end
    end
  end
end
