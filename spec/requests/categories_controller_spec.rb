# frozen_string_literal: true

describe CategoriesController do
  let(:admin) { Fabricate(:admin) }
  let!(:category) { Fabricate(:category, user: admin) }

  describe '#update' do
    before do
      SiteSetting.restricted_replies_enabled = true
      sign_in(admin)
    end

    it "updates `restrict_replies_bypass_groups` custom field correctly" do
      readonly = CategoryGroup.permission_types[:readonly]
      create_post = CategoryGroup.permission_types[:create_post]
      tag_group = Fabricate(:tag_group)

      put "/categories/#{category.id}.json", params: {
        name: "hello",
        color: "ff0",
        text_color: "fff",
        slug: "hello-category",
        auto_close_hours: 72,
        custom_fields: {
          "restrict_replies": true,
          "restrict_replies_bypass_groups" => [1, 2]
        }
      }

      expect(response.status).to eq(200)
      category.reload
      expect(category.custom_fields).to eq("restrict_replies" => true, "restrict_replies_bypass_groups" => [1, 2])
    end
  end
end
