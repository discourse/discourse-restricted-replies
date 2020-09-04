import { default as computed } from "ember-addons/ember-computed-decorators";

export default Ember.Component.extend({
  @computed
  groups() {
    return Ember.makeArray(this.site.groups);
  },
});
