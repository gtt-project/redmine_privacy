module RedminePrivacy
  class Displayname

    def self.call(user)
      if user.displayname.present?
        user.displayname
      else
        # TODO implement that.
        user.name RedminePrivacy.fallback_formatter
      end
    end
  end
end
