import selectKit from "helpers/select-kit-helper";
import { acceptance } from "helpers/qunit-helpers";

acceptance("Restricted Replies Category Edit", {
  loggedIn: true
});

QUnit.test("Restricted Can open the category modal", async assert => {
  await visit("/c/bug");

  await click(".edit-category");
  assert.ok(visible(".d-modal"), "it pops up a modal");

  await click("a.close");
  assert.ok(!visible(".d-modal"), "it closes the modal");
});

QUnit.test("Restricted Editing the category", async assert => {
  await visit("/c/bug");

  await click(".edit-category");
  await click(".edit-category-security");

  await click(".restrict-replies input[type=checkbox]");

  const searchPriorityChooser = selectKit(".restrict-replies .multi-select");
  await searchPriorityChooser.expand();
  await searchPriorityChooser.selectRowByValue(1);

  await click("#save-category");

  assert.ok(!visible(".d-modal"), "it closes the modal");
});
