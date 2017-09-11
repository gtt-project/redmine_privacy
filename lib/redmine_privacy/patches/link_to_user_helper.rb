module RedminePrivacy
  module Patches
    module LinkToUserHelper

      # Overriding ApplicationHelper#link_to_user
      #
      # The goal is to make our version of this method replace the original
      # *everywhere*.
      #
      # Patching the ApplicationHelper module itself will miss all already
      # loaded controller classes (we do not have control over this - any
      # plugin with a 'smaller' name can load controllers by patching them.).
      # Also this does not work with prepend, which is bad because we want to
      # call super.
      #
      # Adding the helper to ApplicationController again only works for
      # controllers that have not yet been loaded.
      #
      # Therefore, to do it truly generically we have to add our helper method
      # override to ApplicationController and any controllers that are already
      # loaded (this is what ApplicationController.descendants gives us):
      def self.apply
        (ApplicationController.descendants +
         [ApplicationController]).each do |controller|

          controller.helper self
        end
      end

      def link_to_user(user, *_)
        if user.visible?
          super user, *_
        else
          PrivateUsername.new(user, project: @project).to_s
        end
      end

    end
  end
end
