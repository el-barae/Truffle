pragma solidity >=0.8.2 <0.9.0;

contract Todo {
    uint public taskCount = 0;

    constructor() {
        createTask("First task");
    }

    struct Task {
        uint id;
        string taskContent;
        bool isCompleted;
    }

    event TaskCreated(uint id, string taskContent, bool isCompleted);
    event TaskCompleted(uint id, bool isCompleted);

    mapping (uint => Task) public tasks;

    function createTask(string memory _taskContent) public {
        taskCount++;
        tasks[taskCount] = Task(taskCount, _taskContent, false);
        emit TaskCreated(taskCount, _taskContent, false);
    }

    function completeTask(uint _id) public {
        Task memory _task = tasks[_id];
        _task.isCompleted = !_task.isCompleted;
        tasks[_id] = _task;

        emit TaskCompleted(_id, _task.isCompleted);
    }
}
