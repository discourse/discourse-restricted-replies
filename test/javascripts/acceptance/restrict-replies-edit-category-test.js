import { click, currentURL, visit } from "@ember/test-helpers";
import { skip } from "qunit";
import formKit from "discourse/tests/helpers/form-kit-helper";
import { acceptance } from "discourse/tests/helpers/qunit-helpers";

acceptance("Restricted Replies Category Edit", function (needs) {
  needs.user();

  skip("Restricted Editing the category", async function (assert) {
    await visit("/c/bug/edit/security");

    await formKit().field("custom_fields.restrict_replies").toggle();
    await formKit()
      .field("custom_fields.restrict_replies_bypass_groups")
      .select(1);

    await click("#save-category");
    assert.strictEqual(
      currentURL(),
      "/c/bug/edit/security",
      "it stays on the edit screen"
    );
  });
});
