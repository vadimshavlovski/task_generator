package com.task_generator.repository;

import com.task_generator.model.Task;
import com.task_generator.model.TaskType;

import java.util.List;

public interface TaskRepository {

    void createTask(Task task);

    Task getTask(int taskId);

    Task updateTask(Task task);

    void deleteTask(int taskId);

    List<Task> getAllTasksByType(TaskType type);

    List<Task> getAllTasksByTypeAndTopic(TaskType type, String topic);

    List<String> getAllTopics();
}
