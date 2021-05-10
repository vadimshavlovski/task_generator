package com.task_generator.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import com.task_generator.exception.TaskNotFoundException;
import com.task_generator.model.Task;
import com.task_generator.model.TaskType;
import com.task_generator.model.TopicWrapper;
import com.task_generator.service.TaskService;
import com.task_generator.utils.MergeUtil;

import java.util.List;

@Transactional
@RestController
@RequestMapping("/tasks")
public class TaskRestController {

    private final TaskService taskService;

    @Autowired
    public TaskRestController(TaskService taskService) {
        this.taskService = taskService;
    }

    @RequestMapping(value = "/topics", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public TopicWrapper getTopics() {
        return taskService.getAllTopics();
    }

    @RequestMapping(value = "", method = RequestMethod.GET)
    public List<Task> getTasksByType(@RequestParam String taskType) {
        return taskService.getAllTaskByType(TaskType.valueOf(taskType));
    }

    @RequestMapping(value = "/random", method = RequestMethod.GET)
    public Task getRandomTask(@RequestParam String taskType) {
        return taskService.getRandomTask(TaskType.valueOf(taskType));
    }

    @RequestMapping(value = "", method = RequestMethod.POST,
            consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseStatus(HttpStatus.CREATED)
    public Task addTask(@RequestBody Task task) {
        taskService.createTask(task);
        return task;
    }

    @RequestMapping(value = "/{taskId}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public Task getTask(@PathVariable("taskId") Integer taskId) {
        Task task = taskService.getTask(taskId);
        return task;
    }

    @RequestMapping(value = "/{taskId}", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_VALUE)
    public Task updateTask(@PathVariable Integer taskId, @RequestBody Task task) {
        if (taskService.getTask(taskId) == null) {
            throw new TaskNotFoundException(taskId.toString());
        }
        task.setId(taskId);
        taskService.updateTask(task);
        return task;
    }

    @RequestMapping(value = "/{taskId}", method = RequestMethod.PATCH, produces = MediaType.APPLICATION_JSON_VALUE)
    public Task patchTask(@PathVariable Integer taskId, @RequestBody Task patchTask) {
        Task oldTask = taskService.getTask(taskId);
        if(oldTask == null){
            throw new TaskNotFoundException(taskId.toString());
        }
        patchTask.setId(taskId);
        MergeUtil.merge(oldTask, patchTask);
        taskService.updateTask(patchTask);
        return patchTask;
    }

    @RequestMapping(value = "/{taskId}", method = RequestMethod.DELETE)
    public ResponseEntity<String> deleteTask(@PathVariable("taskId") Integer taskId) {
        taskService.deleteTask(taskId);
        return new ResponseEntity<>((String.format("Task with id %s was deleted",taskId)), HttpStatus.OK);
    }

}
