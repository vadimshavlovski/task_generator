package com.task_generator.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.task_generator.model.Task;
import com.task_generator.model.TaskType;
import com.task_generator.model.TopicWrapper;
import com.task_generator.repository.TaskRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Transactional
@Service
public class TaskServiceImpl implements TaskService {

    private final TaskRepository taskRepository;

    @Autowired
    public TaskServiceImpl(TaskRepository taskRepository) {
        this.taskRepository = taskRepository;
    }

    @Override
    public void createTask(Task task) {
        taskRepository.createTask(task);
    }

    @Override
    public Task getTask(int taskId) {
        return taskRepository.getTask(taskId);
    }

    @Override
    public Task updateTask(Task task) {
        return taskRepository.updateTask(task);
    }

    @Override
    public void deleteTask(int taskId) {
        taskRepository.deleteTask(taskId);
    }

    @Override
    public List<Task> getAllTaskByType(TaskType type) {
        return taskRepository.getAllTasksByType(type);
    }

    @Override
    public List<Task> getAllTaskByTypeAndTopic(TaskType type, String topic) {
        return taskRepository.getAllTasksByTypeAndTopic(type, topic);
    }

    @Override
    public Task getRandomTask(TaskType type) {
        List<Task> tasks = getAllTaskByType(type);
        int randomValue = getRandomNumber(tasks);
        return tasks.get(randomValue);
    }

    @Override
    public Task getRandomTaskByTypeAndTopics(TaskType type, List<String> topics) {
        List<Task> tasks = new ArrayList<>();
        for (String topic : topics) {
            tasks.addAll(getAllTaskByTypeAndTopic(type, topic));
        }
        int randomValue = getRandomNumber(tasks);
        return tasks.get(randomValue);
    }

    private int getRandomNumber(List<Task> tasks){
        int taskCount = tasks.size();
        int randomTaskNumber = new Random().nextInt(taskCount);
        return randomTaskNumber;
    }

    @Override
    public TopicWrapper getAllTopics() {
        TopicWrapper topics = new TopicWrapper();
        topics.setTopics(taskRepository.getAllTopics());
        return topics;
    }
}
