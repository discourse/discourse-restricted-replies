import Component from "@ember/component";
import discourseComputed from "discourse/lib/decorators";
import { makeArray } from "discourse/lib/helpers";

export default class RestrictRepliesSetting extends Component {
  @discourseComputed
  groups() {
    return makeArray(this.site.groups);
  }
}
