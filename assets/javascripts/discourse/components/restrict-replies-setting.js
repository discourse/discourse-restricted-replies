import Component from "@ember/component";
import { makeArray } from "discourse-common/lib/helpers";
import discourseComputed from "discourse-common/utils/decorators";

export default Component.extend({
  @discourseComputed
  groups() {
    return makeArray(this.site.groups);
  },
});
