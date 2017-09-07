module RedminePrivacy
  module Patches
    module IssuePatch
      def self.apply
        Issue.class_eval do
          after_initialize do
            if new_record? && RedminePrivacy.issues_private_by_default?
              self.is_private = true
            end
          end
        end
      end
    end
  end
end
