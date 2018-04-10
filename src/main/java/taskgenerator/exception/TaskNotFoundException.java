package taskgenerator.exception;


public class TaskNotFoundException extends RuntimeException {


    public TaskNotFoundException(String taskId) {
        super(String.format("could not find task with id %s ", taskId));
    }

}
