# frozen_string_literal: true

module DiscourseRestrictedReplies
  module GuardianExtension
    extend ActiveSupport::Concern

    def can_create_post_on_topic?(topic)
      return super if !SiteSetting.restricted_replies_enabled
      return super if !(category = topic&.category)
      return super if !category.custom_fields["restrict_replies"]
      default_value = super
      if default_value
        in_allowed_group =
          GroupUser.where(
            group_id: topic.category.custom_fields["restrict_replies_bypass_groups"],
            user_id: user.id,
          ).exists?
        return true if is_staff? || in_allowed_group || is_my_own?(topic)
      end
      false
    end
  end
end
