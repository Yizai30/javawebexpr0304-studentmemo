package vo;

import java.util.Date;

public class Diary {
    private int id;
    private String username;
    private Date createTime;
    private String content;
    private String mood;

    public Diary() {
    }

    public Diary(int id, String username, Date createTime, String content, String mood) {
        this.id = id;
        this.username = username;
        this.createTime = createTime;
        this.content = content;
        this.mood = mood;
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

    public String getMood() {
        return mood;
    }

    public void setMood(String mood) {
        this.mood = mood;
    }
}
