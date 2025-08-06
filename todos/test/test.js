const Todo = artifacts.require("Todo");

contract("Todo", (accounts) => {
  it("doit démarrer avec zéro tâche", async () => {
    const todo = await Todo.deployed();
    const count = await todo.taskCount();
    assert.strictEqual(count.toNumber(), 0);
  });
});
