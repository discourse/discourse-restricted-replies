import selectKit from "discourse/tests/helpers/select-kit-helper";
import { acceptance } from "discourse/tests/helpers/qunit-helpers";

acceptance("Restricted Replies Category Edit", function (needs) {
  needs.user();

  test("Restricted Editing the category", async (assert) => {
    await visit("/c/bug/edit/security");

    await click(".restrict-replies input[type=checkbox]");

    const searchPriorityChooser = selectKit(".restrict-replies .multi-select");
    await searchPriorityChooser.expand();
    await searchPriorityChooser.selectRowByValue(1);

    await click("#save-category");
    assert.equal(
      currentURL(),
      "/c/bug/edit/security",
      "it stays on the edit screen"
    );
  });
});
