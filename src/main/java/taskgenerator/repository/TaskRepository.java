package taskgenerator.repository;

import taskgenerator.model.Task;
import taskgenerator.model.TaskTypes;

import java.util.List;

public interface TaskRepository {

    void createTask(Task task);

    Task getTask(int taskId);

    Task updateTask(Task task);

    void deleteTask(int taskId);

    List<Task> getAllTasksByType(TaskTypes type);

    List<Task> getAllTasksByTypeAndTopic(TaskTypes type, String topic);

    List<String> getAllTopics();
}
