package taskgenerator.service;

import taskgenerator.model.Task;
import taskgenerator.model.TaskType;
import taskgenerator.model.TopicWrapper;

import java.util.List;

public interface TaskService {

    void createTask(Task task);

    Task getTask(int taskId);

    Task updateTask(Task task);

    void deleteTask(int taskId);

    List<Task> getAllTaskByType(TaskType type);

    List<Task> getAllTaskByTypeAndTopic(TaskType type, String topic);

    Task getRandomTask(TaskType type);

    Task getRandomTaskByTypeAndTopics(TaskType type, List<String> topics);

    TopicWrapper getAllTopics();
}
