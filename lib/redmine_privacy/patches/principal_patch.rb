module RedminePrivacy
  module Patches
    module PrincipalPatch

      def self.apply
        return if Principal < self

        Principal.prepend self # merely as a marker so we dont do it twice

        class << Principal
          alias_method :visible_before_privacy, :visible

          def visible(*args)
            user = args.first || User.current
            if user.allowed_to?(:view_users, nil, global: true)
              visible_before_privacy(*args)
            else
              where(id: user.id) # just self
            end
          end
        end

      end

    end
  end
end
