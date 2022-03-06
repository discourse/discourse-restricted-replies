import Component from "@ember/component";
import discourseComputed from "discourse-common/utils/decorators";
import { makeArray } from "discourse-common/lib/helpers";

export default Component.extend({
  @discourseComputed
  groups() {
    return makeArray(this.site.groups);
  },
});
