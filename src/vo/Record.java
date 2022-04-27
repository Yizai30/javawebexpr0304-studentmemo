package vo;

import java.util.Date;

public class Record {
    private int id;
    private String username;
    private Date createTime;
    private Date deadLine;
    private String content;
    private boolean isComplete;

    public Record() {
    }

    public Record(int id, String username, Date createTime, String content, boolean isComplete) {
        this.id = id;
        this.username = username;
        this.createTime = createTime;
        this.content = content;
        this.isComplete = isComplete;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isComplete() {
        return isComplete;
    }

    public void setComplete(boolean complete) {
        isComplete = complete;
    }
}
