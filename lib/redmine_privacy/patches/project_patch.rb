module RedminePrivacy
  module Patches
    module ProjectPatch
      def self.apply
        unless Project < self
          Project.prepend self
          Project.class_eval do
            safe_attributes :issues_private_by_default,
              :warn_when_creating_public_issue,
              :issue_notes_private_by_default
          end
        end
      end

    end
  end
end
