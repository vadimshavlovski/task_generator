package taskgenerator.model;

import java.io.Serializable;
import java.util.List;

public class TopicWrapper implements Serializable {

    private List<String> topics;

    public TopicWrapper() {
    }

    public TopicWrapper(List<String> topics) {
        this.topics = topics;
    }

    public List<String> getTopics() {
        return topics;
    }

    public void setTopics(List<String> topics) {
        this.topics = topics;
    }
}
