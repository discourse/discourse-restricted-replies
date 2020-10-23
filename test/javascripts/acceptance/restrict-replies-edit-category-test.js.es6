import selectKit from "helpers/select-kit-helper";
import { acceptance } from "helpers/qunit-helpers";

acceptance("Restricted Replies Category Edit", {
  loggedIn: true,
});

QUnit.test("Restricted Editing the category", async (assert) => {
  await visit("/c/bug");

  await click("button.edit-category");
  await click(".edit-category-security a");

  await click(".restrict-replies input[type=checkbox]");

  const searchPriorityChooser = selectKit(".restrict-replies .multi-select");
  await searchPriorityChooser.expand();
  await searchPriorityChooser.selectRowByValue(1);

  await click("#save-category");
  assert.equal(currentURL(), "/c/bug/edit", "it stays on the edit screen");
});
