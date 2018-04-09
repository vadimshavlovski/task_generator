package taskgenerator.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import taskgenerator.model.Mapper;
import taskgenerator.model.Task;
import taskgenerator.model.TaskTypes;
import taskgenerator.model.TopicWrapper;
import taskgenerator.service.TaskService;
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
        return taskService.getAllTaskByType(TaskTypes.valueOf(taskType));
    }

    @RequestMapping(value = "/random", method = RequestMethod.GET)
    public Task getRandomTask(@RequestParam String taskType) {
        return taskService.getRandomTask(TaskTypes.valueOf(taskType));
    }

    @RequestMapping(value = "", method = RequestMethod.POST,
            consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
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
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity updateTask(@PathVariable Integer taskId, @RequestBody Task task) {
        if (taskService.getTask(taskId) == null) {
                return new ResponseEntity("No Task found for ID " + taskId, HttpStatus.NOT_FOUND);
        }
        task.setId(taskId);
        taskService.updateTask(task);
        return new ResponseEntity(task,HttpStatus.OK);
    }

    @RequestMapping(value = "/{taskId}", method = RequestMethod.PATCH, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity patchTask(@PathVariable Integer taskId, @RequestBody Task patchTask) {
        Task oldTask = taskService.getTask(taskId);
        if(oldTask == null){
            return new ResponseEntity("No Task found for ID " + taskId, HttpStatus.NOT_FOUND);
        }
        patchTask.setId(taskId);
        Mapper.map(oldTask, patchTask);
        taskService.updateTask(patchTask);
        return new ResponseEntity(patchTask,HttpStatus.OK);
    }

    @RequestMapping(value = "/{taskId}", method = RequestMethod.DELETE)
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity deleteTask(@PathVariable("taskId") Integer taskId) {
        taskService.deleteTask(taskId);
        return new ResponseEntity("Task with id -" + taskId + " was deleted",HttpStatus.OK);
    }

}
