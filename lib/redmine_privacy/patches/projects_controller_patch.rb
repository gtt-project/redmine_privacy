module RedminePrivacy
  module Patches
    module ProjectsControllerPatch

      def self.apply
        ProjectsController.prepend self unless ProjectsController < self
      end


      def respond_to(*_, &block)
        if params[:action] == 'show'
          # having no users effectively hides the project members box
          @users_by_role = []
        end
        super(*_, &block)
      end
    end
  end
end
