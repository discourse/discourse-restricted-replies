# frozen_string_literal: true

# name: discourse-restricted-replies
# about: Restricts replies in certain categories to the OP and specified groups.
# meta_topic_id: 131343
# version: 1.0
# author: David Taylor
# url: https://github.com/discourse/discourse-restricted-replies

enabled_site_setting :restricted_replies_enabled

register_asset "stylesheets/restrict-replies.scss"

after_initialize do
  require_relative "lib/discourse_restricted_replies/guardian_extension"

  register_category_custom_field_type "restrict_replies", :boolean
  register_category_custom_field_type "restrict_replies_bypass_groups", [:integer]

  reloadable_patch { Guardian.prepend(DiscourseRestrictedReplies::GuardianExtension) }
end
