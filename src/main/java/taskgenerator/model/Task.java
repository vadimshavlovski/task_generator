package taskgenerator.model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "tasks")
public class Task implements Serializable {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "topic")
    private String topic;

    @Column(name = "type")
    @Enumerated(EnumType.STRING)
    private TaskType type;

    public Task() {
    }

    public Task(int id, String name, String description, String topic, TaskType type) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.topic = topic;
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public TaskType getType() {
        return type;
    }

    public void setType(TaskType type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Task{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", topic='" + topic + '\'' +
                ", type=" + type +
                '}';
    }
}
