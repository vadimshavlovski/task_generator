package taskgenerator.service;

import taskgenerator.model.Task;
import taskgenerator.model.TaskTypes;
import taskgenerator.model.TopicWrapper;

import java.util.List;

public interface TaskService {

    void createTask(Task task);

    Task getTask(int taskId);

    Task updateTask(Task task);

    void deleteTask(int taskId);

    List<Task> getAllTaskByType(TaskTypes type);

    List<Task> getAllTaskByTypeAndTopic(TaskTypes type, String topic);

    Task getRandomTask(TaskTypes type);

    Task getRandomTaskByTypeAndTopics(TaskTypes type, List<String> topics);

    TopicWrapper getAllTopics();
}
