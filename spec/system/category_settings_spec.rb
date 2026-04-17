# frozen_string_literal: true

RSpec.describe "Restricted Replies Category Settings" do
  fab!(:admin)
  fab!(:category)
  fab!(:group)

  let(:category_page) { PageObjects::Pages::Category.new }
  let(:form) { PageObjects::Components::FormKit.new(".form-kit") }
  let(:banner) { PageObjects::Components::AdminChangesBanner.new }
  let(:toasts) { PageObjects::Components::Toasts.new }

  before do
    SiteSetting.restricted_replies_enabled = true
    sign_in(admin)
  end

  context "when simplified category creation is enabled" do
    before { SiteSetting.enable_simplified_category_creation = true }

    it "can toggle restrict replies and select bypass groups via FormKit" do
      category_page.visit_security(category)

      form.field("custom_fields.restrict_replies").toggle
      expect(page).to have_css("[data-name='custom_fields.restrict_replies_bypass_groups']")

      banner.click_save

      expect(toasts).to have_success(I18n.t("js.saved"))
      category.reload
      expect(category.custom_fields["restrict_replies"]).to eq(true)
    end
  end

  context "when simplified category creation is disabled" do
    before { SiteSetting.enable_simplified_category_creation = false }

    it "can toggle restrict replies and see bypass groups via legacy form" do
      category_page.visit_security(category)

      find("#restrict-replies").click
      expect(page).to have_css(".restrict-replies .multi-select")

      category_page.save_settings

      expect(toasts).to have_success(I18n.t("js.saved"))
      category.reload
      expect(category.custom_fields["restrict_replies"]).to eq(true)
    end
  end
end
