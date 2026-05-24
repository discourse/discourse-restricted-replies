import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { makeArray } from "discourse/lib/helpers";
import MultiSelect from "discourse/select-kit/components/multi-select";
import { i18n } from "discourse-i18n";

export default class RestrictRepliesSetting extends Component {
  @service site;

  @tracked _restrictReplies = null;

  get restrictReplies() {
    if (this._restrictReplies !== null) {
      return this._restrictReplies;
    }
    return this.args.outletArgs.category.custom_fields.restrict_replies;
  }

  get groups() {
    return makeArray(this.site.groups);
  }

  @action
  onFormSetRestrictReplies(value, { set, name }) {
    this._restrictReplies = value;
    set(name, value);
  }

  @action
  onChangeRestrictReplies(event) {
    this.args.outletArgs.category.set(
      "custom_fields.restrict_replies",
      event.target.checked
    );
    this._restrictReplies = event.target.checked;
  }

  @action
  onChangeBypassGroups(value) {
    this.args.outletArgs.category.set(
      "custom_fields.restrict_replies_bypass_groups",
      value
    );
  }

  <template>
    <@outletArgs.form.Section @title={{i18n "restricted_replies.title"}}>
      <@outletArgs.form.Object @name="custom_fields" as |object|>
        <object.Field
          @name="restrict_replies"
          @title={{i18n "restricted_replies.for_category"}}
          @format="max"
          @type="checkbox"
          @onSet={{this.onFormSetRestrictReplies}}
          as |field|
        >
          <field.Control />
        </object.Field>

        {{#if this.restrictReplies}}
          <object.Field
            @name="restrict_replies_bypass_groups"
            @title={{i18n "restricted_replies.bypass_groups"}}
            @format="max"
            @type="custom"
            as |field|
          >
            <field.Control>
              <MultiSelect
                @id={{field.id}}
                @content={{this.groups}}
                @allowAny={{false}}
                @value={{field.value}}
                @onChange={{field.set}}
              />
            </field.Control>
          </object.Field>
        {{/if}}
      </@outletArgs.form.Object>
    </@outletArgs.form.Section>
  </template>
}
