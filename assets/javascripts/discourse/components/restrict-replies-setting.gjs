/* eslint-disable ember/no-classic-components, ember/require-tagless-components */
import Component, { Input } from "@ember/component";
import { fn } from "@ember/helper";
import { computed } from "@ember/object";
import { makeArray } from "discourse/lib/helpers";
import MultiSelect from "discourse/select-kit/components/multi-select";
import { i18n } from "discourse-i18n";

export default class RestrictRepliesSetting extends Component {
  @computed
  get groups() {
    return makeArray(this.site.groups);
  }

  <template>
    <section class="field restrict-replies">
      <h3>{{i18n "restricted_replies.title"}}</h3>
      <label>
        <Input
          @type="checkbox"
          @checked={{this.category.custom_fields.restrict_replies}}
        />
        {{i18n "restricted_replies.for_category"}}
      </label>
      {{#if this.category.custom_fields.restrict_replies}}
        <MultiSelect
          @content={{this.groups}}
          @allowAny={{false}}
          @value={{this.category.custom_fields.restrict_replies_bypass_groups}}
          @onSelect={{fn
            (mut this.category.custom_fields.restrict_replies_bypass_groups)
          }}
        />
      {{/if}}
    </section>
  </template>
}
