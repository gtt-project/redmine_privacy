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

      def assignable_users
        super.select(&:visible?)
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

      def init_journal(*_)
        super.tap do
          if project && project.issue_notes_private_by_default?
            self.private_notes = true
          end
        end
      end

    end
  end
end
