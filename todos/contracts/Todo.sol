pragma solidity >=0.8.2 <0.9.0;

contract Todo {
    uint public taskCount = 0;
    
    struct Task {
        uint id;
        string taskContent;
        bool isCompleted;
        uint256 createdAt;     
        address creator;      
    }
    
    event TaskCreated(uint indexed id, string taskContent, address indexed creator);
    event TaskCompleted(uint indexed id, bool isCompleted, address indexed user);
    
    mapping (uint => Task) public tasks;
    
    modifier taskExists(uint _id) {
        require(_id > 0 && _id <= taskCount, "Cette tache n'existe pas");
        _;
    }
    
    constructor() {}
    
    function createTask(string memory _taskContent) public {
        // Validation : le contenu ne peut pas être vide
        require(bytes(_taskContent).length > 0, "Le contenu de la tache ne peut pas etre vide");
        
        taskCount++;
        
        // Stockage avec plus d'informations
        tasks[taskCount] = Task({
            id: taskCount,
            taskContent: _taskContent,
            isCompleted: false,
            createdAt: block.timestamp,  
            creator: msg.sender
        });
        
        emit TaskCreated(taskCount, _taskContent, msg.sender);
    }
    
    function completeTask(uint _id) public taskExists(_id) {
        Task storage task = tasks[_id];
        task.isCompleted = !task.isCompleted;
        
        emit TaskCompleted(_id, task.isCompleted, msg.sender);
    }
    
    function getTask(uint _id) public view taskExists(_id) returns (
        uint id,
        string memory content,
        bool completed,
        uint256 createdAt,
        address creator
    ) {
        Task memory task = tasks[_id];
        return (task.id, task.taskContent, task.isCompleted, task.createdAt, task.creator);
    }
    
    function getAllTasks() public view returns (Task[] memory) {
        Task[] memory allTasks = new Task[](taskCount);
        
        for (uint i = 1; i <= taskCount; i++) {
            allTasks[i-1] = tasks[i];
        }
        
        return allTasks;
    }
    
    function deleteTask(uint _id) public taskExists(_id) {
        delete tasks[_id];

        // tasks[_id].taskContent = "[SUPPRIMEE]";
    }
}