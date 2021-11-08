module RedminePrivacy
  module Patches
    module ProjectsControllerPatch

      def self.apply
        ProjectsController.prepend self unless ProjectsController < self
      end


      def respond_to(*_, &block)
        if params[:action] == 'show'
          # having no users effectively hides the project members box
          if Redmine::VERSION.to_a[0] >= 4 && Redmine::VERSION.to_a[1] >= 2
            @principals_by_role = []
          else
            @users_by_role = []
          end
        end
        super(*_, &block)
      end
    end
  end
end
