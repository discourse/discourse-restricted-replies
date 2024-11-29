import Component from "@ember/component";
import { makeArray } from "discourse-common/lib/helpers";
import discourseComputed from "discourse-common/utils/decorators";

export default class RestrictRepliesSetting extends Component {
  @discourseComputed
  groups() {
    return makeArray(this.site.groups);
  }
}
