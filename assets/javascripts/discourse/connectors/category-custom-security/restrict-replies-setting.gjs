import Component from "@ember/component";
import { classNames, tagName } from "@ember-decorators/component";
import RestrictRepliesSetting0 from "../../components/restrict-replies-setting";

@tagName("")
@classNames("category-custom-security-outlet", "restrict-replies-setting")
export default class RestrictRepliesSetting extends Component {
  <template><RestrictRepliesSetting0 @category={{this.category}} /></template>
}
