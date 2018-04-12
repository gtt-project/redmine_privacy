module RedminePrivacy
  module Patches
    module UserPatch

      def self.apply
        return if User < self

        User.prepend self

        User.class_eval do
          safe_attributes 'displayname'
          class << self
            prepend ClassMethods
          end
        end

        User::USER_FORMATS[:displayname] = {
          string: '#{RedminePrivacy::Displayname.(self)}',
          order: %w(displayname id),
          setting_order: 9
        }
      end

      def name(formatter = nil)
        if visible?
          super
        else
          PrivateUsername.new(self).to_s
        end
      end

      module ClassMethods
        def fields_for_order_statement(table = nil)
          if Setting.user_format == :displayname
            table ||= table_name
            fallback = User::USER_FORMATS[RedminePrivacy.displayname_fallback]
            fields = (fallback[:order] - ['id']).map {|field| "#{table}.#{field}"}
            others = fields.one? ? fields[0] : "CONCAT(#{fields.join ",' ',"})"
            ["COALESCE(NULLIF(#{table}.displayname,''), #{others})", "#{table}.id"]
          else
            super
          end
        end
      end

    end
  end
end
