import { default as computed } from "discourse-common/utils/decorators";

export default Ember.Component.extend({
  @computed
  groups() {
    return Ember.makeArray(this.site.groups);
  },
});
