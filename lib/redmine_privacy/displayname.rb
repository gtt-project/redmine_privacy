module RedminePrivacy
  class Displayname

    def self.call(user)
      if user.displayname.present?
        user.displayname
      else
        user.name RedminePrivacy.displayname_fallback
      end
    end
  end
end
