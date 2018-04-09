package taskgenerator.repository;

import org.springframework.stereotype.Repository;
import taskgenerator.model.Task;
import taskgenerator.model.TaskTypes;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.Collections;
import java.util.List;

@Repository
public class TaskRepositoryImpl implements TaskRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void createTask(Task task) {
        entityManager.persist(task);
    }

    @Override
    public Task getTask(int taskId) {
        Task task = entityManager.find(Task.class, taskId);
        return task;
    }

    @Override
    public Task updateTask(Task task) {
        return entityManager.merge(task);
    }

    @Override
    public void deleteTask(int taskId) {
        Task task = entityManager.find(Task.class, taskId);
        if(task != null){
            entityManager.remove(task);
        }
    }

    // using jpa query
    @Override
    public List<Task> getAllTasksByType(TaskTypes type) {
        Query query = entityManager.createQuery(
                "SELECT tasks FROM Task tasks WHERE type = :type", Task.class);
        query.setParameter("type", type);
        return getTaskListFromQuery(query);
    }

    // using native query
    @Override
    public List<Task> getAllTasksByTypeAndTopic(TaskTypes type, String topic) {
        Query query = entityManager.createNativeQuery(
                "select * from tasks where type = ? and topic = ?", Task.class);
        query.setParameter(1, type.toString());
        query.setParameter(2, topic);
        return getTaskListFromQuery(query);
    }

    private List<Task> getTaskListFromQuery(Query query){
        List<Task> tasks = query.getResultList();
        if (tasks.size() == 0) {
            return Collections.emptyList();
        }
        return tasks;
    }

    @Override
    public List<String> getAllTopics() {
        Query query = entityManager.createNativeQuery("select topic from tasks group by topic");
        return query.getResultList();
    }
}
