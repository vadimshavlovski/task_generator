package com.task_generator.service;

import com.task_generator.model.Task;
import com.task_generator.model.TaskType;
import com.task_generator.model.TopicWrapper;

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
