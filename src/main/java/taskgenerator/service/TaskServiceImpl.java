package taskgenerator.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import taskgenerator.model.Task;
import taskgenerator.model.TaskTypes;
import taskgenerator.model.TopicWrapper;
import taskgenerator.repository.TaskRepository;

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
    public List<Task> getAllTaskByType(TaskTypes type) {
        return taskRepository.getAllTasksByType(type);
    }

    @Override
    public List<Task> getAllTaskByTypeAndTopic(TaskTypes type, String topic) {
        return taskRepository.getAllTasksByTypeAndTopic(type, topic);
    }

    @Override
    public Task getRandomTask(TaskTypes type) {
        List<Task> tasks = getAllTaskByType(type);
        int randomValue = getRandomNumber(tasks);
        return tasks.get(randomValue);
    }

    @Override
    public Task getRandomTaskByTypeAndTopics(TaskTypes type, List<String> topics) {
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
