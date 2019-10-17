# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "restricted_replies" do
  let(:category) { Fabricate(:category) }
  let(:group) { Fabricate(:group) }
  let(:admin) { Fabricate(:admin) }
  let(:user) { Fabricate(:user) }
  let(:topic) { Fabricate(:topic, category: category) }
  let(:pm) { Fabricate(:private_message_topic) }

  before { group.add(user) }

  before { sign_in(user) }

  def can_create_post(t: topic)
    expect do
      get "/t/#{t.id}.json"
      expect(JSON.parse(response.body)["details"]["can_create_post"]).to eq(true)
      post "/posts.json", params: {
        raw: 'this is test body',
        topic_id: t.id
      }
      expect(response.status).to eq(200)
    end.to change { t.posts.count }.by 1
  end

  def cannot_create_post
    get "/t/#{topic.id}.json"
    expect(JSON.parse(response.body)["details"]["can_create_post"]).to eq(nil)
    expect do
      post "/posts.json", params: {
        raw: 'this is test body',
        topic_id: topic.id
      }
      expect(response.status).to eq(422)
    end.to change { topic.posts.count }.by 0
  end

  describe "guardian logic" do
    before { SiteSetting.restricted_replies_enabled = true }

    it "allows posting by default" do
      can_create_post
    end

    context "with a restricted category" do
      before do
        category.custom_fields["restrict_replies"] = true
        category.save!
      end

      it "prevents posting when enabled for category" do
        cannot_create_post
      end

      it "allows the OP to reply" do
        topic.update!(user: user)
        can_create_post
      end

      it "doesn't break PMs" do
        sign_in(Fabricate(:admin))
        can_create_post(t: pm)
      end

      it "always allows staff to post" do
        sign_in(Fabricate(:admin))
        can_create_post
      end

      it "allows posting when in an allowed group" do
        category.custom_fields["restrict_replies_bypass_groups"] = [group.id]
        category.save!
        can_create_post
      end
    end

  end
end
