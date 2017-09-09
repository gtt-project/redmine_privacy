module RedminePrivacy
  module Patches
    module IssuePatch

      def self.apply
        unless Issue < self
          Issue.prepend self
          Issue.class_eval do
            after_initialize :privacy_set_private_flag
          end
        end
      end

      def project=(*_)
        super
        privacy_set_private_flag
      end

      def privacy_set_private_flag
        if new_record? && project && project.issues_private_by_default?
          self.is_private = true
        end
      end
      private :privacy_set_private_flag

    end
  end
end
