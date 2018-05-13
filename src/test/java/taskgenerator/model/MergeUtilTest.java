package taskgenerator.model;

import org.junit.Test;

import static org.junit.Assert.*;

public class MergeUtilTest {

    @Test
    public void checkTaskMerge() throws Exception {

        Task oldTask = new Task(1, "Old Name", "Old Description", "Old topic", TaskType.EXERCISE);
        Task newTask = new Task(1, null, "new description", null, TaskType.QUESTION);

        MergeUtil.merge(oldTask, newTask);

        assertEquals(oldTask.getId(), newTask.getId());
        assertEquals(oldTask.getName(), newTask.getName());
        assertNotEquals(oldTask.getDescription(), newTask.getDescription());
        assertEquals(oldTask.getTopic(), newTask.getTopic());
        assertNotEquals(oldTask.getType(), newTask.getType());
    }
}