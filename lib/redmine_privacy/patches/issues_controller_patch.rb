module RedminePrivacy
  module Patches
    module IssuesControllerPatch
      def self.apply
        return if IssuesController < self

        # Make some noise and fail in case issues controller gets refactored
        # and our hook disappears.
        unless IssuesController.private_instance_methods.include? :retrieve_previous_and_next_issue_ids
          fail "this plugin is not compatible with the current Redmine version:\nIssuesController#retrieve_previous_and_next_issue_ids was not found. Please revise the IssuesControllerPatch."
        end

        IssuesController.prepend self
      end

      private

      # this method is called only from #show for the html format and, lacking
      # any real hooks, serves as the hook for us to initialize the journal.
      #
      # init_journal will set the private_notes flag if necessary.
      def retrieve_previous_and_next_issue_ids(*_)
        @issue.init_journal User.current
        super
      end
    end
  end
end
