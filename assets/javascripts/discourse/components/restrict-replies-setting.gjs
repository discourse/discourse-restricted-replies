import Component, { Input } from "@ember/component";
import discourseComputed from "discourse/lib/decorators";
import { makeArray } from "discourse/lib/helpers";
import { i18n } from "discourse-i18n";
import MultiSelect from "select-kit/components/multi-select";

export default class RestrictRepliesSetting extends Component {
  @discourseComputed
  groups() {
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
          @onSelect={{action
            (mut this.category.custom_fields.restrict_replies_bypass_groups)
          }}
        />
      {{/if}}
    </section>
  </template>
}
