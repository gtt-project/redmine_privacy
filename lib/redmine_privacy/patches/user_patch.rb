module RedminePrivacy
  module Patches
    module UserPatch

      def self.apply
        User.prepend self unless User < self
      end

      def name(*_)
        if visible?
          super
        else
          PrivateUsername.new(self).to_s
        end
      end

    end
  end
end
