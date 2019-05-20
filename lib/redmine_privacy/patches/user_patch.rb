module RedminePrivacy
  module Patches
    module UserPatch

      module RenderDisplaynameInApi
        def render_api_custom_values(custom_values, api)
          if @user
            api.displayname @user.displayname
          end
          super
        end
      end

      def self.apply
        return if User < self

        MyController.class_eval do
          helper RedminePrivacy::Patches::UserPatch::RenderDisplaynameInApi
        end
        User.prepend self

        User.class_eval do
          safe_attributes 'displayname'
          class << self
            prepend ClassMethods
          end
        end

        User::USER_FORMATS[:displayname] = {
          string: '#{RedminePrivacy::Displayname.(self)}',
          order: %w(displayname login id),
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
        # fails with Redmine 4 due to the coalesce
        # https://hub.georepublic.net/gtt/redmine_privacy/issues/14
#        def fields_for_order_statement(table = nil)
#          if Setting.user_format == :displayname
#            table ||= table_name
#            fallback = User::USER_FORMATS[RedminePrivacy.displayname_fallback]
#            fields = (fallback[:order] - ['id']).map {|field| "#{table}.#{field}"}
#            others = fields.one? ? fields[0] : "CONCAT(#{fields.join ",' ',"})"
#            ["COALESCE(NULLIF(#{table}.displayname,''), #{others})", "#{table}.id"]
#          else
#            super
#          end
#        end
      end

    end
  end
end
