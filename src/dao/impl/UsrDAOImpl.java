package dao.impl;

import dao.IUsrDAO;
import vo.Diary;
import vo.Passwd;
import vo.Event;
import vo.Usr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

public class UsrDAOImpl implements IUsrDAO {
    private Connection conn = null;
    private PreparedStatement pstmt = null;
    public UsrDAOImpl(Connection conn){
        this.conn = conn;
    }

    @Override
    public boolean doCreateUsr(Usr usr) throws Exception {

        // 如果用户 username 存在，则注册无效
        if (findByUsername(usr.getUsername()) != null) {
            System.out.println("该用户已存在，无法向 usr_info 表中插入记录，注册无效");
            return false;
        }

        // 向 usr_info 表中插入行
        boolean flag = false;
        String sql = "INSERT INTO usr_info(username,gender,age,email) VALUES (?,?,?,?)";
        this.pstmt = this.conn.prepareStatement(sql);
//        if (!checkUsername(usr.getUsername()) || !checkAge(usr.getAge())) {
//            System.out.println("注册信息不合法");
//            return false;
//        }
        this.pstmt.setString(1, usr.getUsername());
        this.pstmt.setByte(2, usr.getGender());
        this.pstmt.setInt(3, usr.getAge());
        this.pstmt.setString(4, usr.getEmail());
        if (this.pstmt.executeUpdate() > 0) {
            System.out.println("usr_info insert successfully.");
            flag = true;
        }

        this.pstmt.close();
        return flag;
    }

    @Override
    public boolean doCreatePasswd(Passwd passwd) throws Exception {

        // 如果用户 username 存在，则注册无效
        if (findByUsername2(passwd.getUsername()) != null) {
            System.out.println("该用户已存在，无法向 usr_passwd 表中插入记录，注册无效");
            return false;
        }

        // 向 usr_passwd 表中插入行
        boolean flag = false;
        String sql = "INSERT INTO usr_passwd(username,password) VALUES (?,?)";
        this.pstmt = this.conn.prepareStatement(sql);
//        if (!checkUsername(usr.getUsername()) || !checkAge(usr.getAge())) {
//            System.out.println("注册信息不合法");
//            return false;
//        }
        this.pstmt.setString(1, passwd.getUsername());
        this.pstmt.setString(2, passwd.getPassword());
        if (this.pstmt.executeUpdate() > 0) {
            System.out.println("usr_passwd insert successfully.");
            flag = true;
        }

        this.pstmt.close();
        return flag;
    }

    @Override
    public Usr findByUsername(String username) throws Exception {
        Usr usr=null;
        String sql = "SELECT id,username,gender,age,email FROM usr_info WHERE username=?";
        this.pstmt = this.conn.prepareStatement(sql);
        this.pstmt.setString(1, username);
        ResultSet rs = this.pstmt.executeQuery();
        while (rs.next()) {
            usr = new Usr();
            usr.setId(rs.getInt(1));
            usr.setUsername(rs.getString(2));
            usr.setGender(rs.getByte(3));
            usr.setAge(rs.getInt(4));
            usr.setEmail(rs.getString(5));
        }

        this.pstmt.close();
        return usr;
    }

    @Override
    public Passwd findByUsername2(String username) throws Exception {
        Passwd passwd = null;
        String sql = "SELECT id,username,password FROM usr_passwd WHERE username=?";
        this.pstmt = this.conn.prepareStatement(sql);
        this.pstmt.setString(1, username);
        ResultSet rs = this.pstmt.executeQuery();
        while (rs.next()) {
            passwd = new Passwd();
            passwd.setId(rs.getInt(1));
            passwd.setUsername(rs.getString(2));
            passwd.setPassword(rs.getString(3));
        }

        this.pstmt.close();
        return passwd;
    }

    @Override
    public boolean check(Passwd passwd) throws Exception {
        boolean flag = false;
        String sql = "SELECT username FROM usr_passwd WHERE username=? and password=?" ;
        this.pstmt=this.conn.prepareStatement(sql);
        this.pstmt.setString(1, passwd.getUsername());
        this.pstmt.setString(2, passwd.getPassword());
        ResultSet rs = this.pstmt.executeQuery();
        if (rs.next()) {
            flag = true;
        }
        else {
            flag = false;
        }

        this.pstmt.close();
        return flag;
    }

    @Override
    public boolean doCreateEvent(Event event) throws Exception {

        // 转换 createTime 类型
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        sdf.setTimeZone(TimeZone.getTimeZone("GMT+8:00"));
        java.util.Date date = sdf.parse(sdf.format(event.getCreateTime()));
        java.sql.Timestamp datesql = new java.sql.Timestamp(date.getTime());

        // 转换 deadLine 类型
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date date2 = sdf.parse(sdf.format(event.getDeadLine()));
        java.sql.Date datesql2 = new java.sql.Date(date2.getTime());

        // 向 record_info 表中插入行
        boolean flag = false;
        String sql = "INSERT INTO event_info(username,create_time,deadline,content,is_complete) VALUES (?,?,?,?,?)";
        this.pstmt = this.conn.prepareStatement(sql);
        this.pstmt.setString(1, event.getUsername());
        this.pstmt.setTimestamp(2, datesql);
        this.pstmt.setDate(3, datesql2);
        this.pstmt.setString(4, event.getContent());
        this.pstmt.setBoolean(5, event.isComplete());
        if (this.pstmt.executeUpdate() > 0) {
            System.out.println("event_info insert successfully.");
            flag = true;
        }

        this.pstmt.close();
        return flag;
    }

    @Override
    public List<Event> findEventByUsername(String username) throws Exception {

        List<Event> events = new ArrayList<Event>();
        String sql = "SELECT id,username,create_time,deadline,content,is_complete FROM event_info WHERE username=?";
        this.pstmt = this.conn.prepareStatement(sql);
        this.pstmt.setString(1,username);
        ResultSet rs = this.pstmt.executeQuery();
        while (rs.next()) {

            Event event = new Event();

            event.setId(rs.getInt(1));
            event.setUsername(rs.getString(2));
            event.setCreateTime(rs.getDate(3));
            event.setDeadLine(rs.getDate(4));
            event.setContent(rs.getString(5));
            event.setComplete(rs.getBoolean(6));

            events.add(event);
        }

        this.pstmt.close();
        return events;
    }

    @Override
    public int delEventById(int id) throws Exception {

        int cnt = 0;
        String sql = "DELETE FROM event_info WHERE id=?";
        this.pstmt = this.conn.prepareStatement(sql);
        this.pstmt.setInt(1,id);
        if (this.pstmt.executeUpdate() == 1) {
            System.out.println("delete from event_info successfully.");
            cnt = 1;
        }

        this.pstmt.close();
        return cnt;
    }

    @Override
    public int edtEventById(int id, java.util.Date deadLine, String content) throws Exception {

        // 转换 deadLine 类型
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date date = sdf.parse(sdf.format(deadLine));
        java.sql.Date datesql = new java.sql.Date(date.getTime());

        int cnt = 0;
        String sql = "UPDATE event_info SET deadline=?,content=? WHERE id=?";
        this.pstmt = this.conn.prepareStatement(sql);
        this.pstmt.setDate(1, datesql);
        this.pstmt.setString(2,content);
        this.pstmt.setInt(3, id);
        if ((cnt = this.pstmt.executeUpdate()) == 1) {
            System.out.println("edit event_info successfully.");
        }

        this.pstmt.close();
        return cnt;
    }

    @Override
    public boolean doCreateDiary(Diary diary) throws Exception {

        // 转换 createTime 类型
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date date = sdf.parse(sdf.format(diary.getCreateTime()));
        java.sql.Date datesql = new java.sql.Date(date.getTime());

        // 向 diary_info 表中插入行
        boolean flag = false;
        String sql = "INSERT INTO diary_info(username,create_time,content,mood) VALUES (?,?,?,?)";
        this.pstmt = this.conn.prepareStatement(sql);
        this.pstmt.setString(1,diary.getUsername());
        this.pstmt.setDate(2, datesql);
        this.pstmt.setString(3, diary.getContent());
        this.pstmt.setString(4, diary.getMood());
        if (this.pstmt.executeUpdate() > 0) {
            System.out.println("diary_info insert successfully.");
            flag = true;
        }

        this.pstmt.close();
        return flag;
    }

    @Override
    public List<Diary> findDiaryByUsername(String username) throws Exception {

        List<Diary> diaries = new ArrayList<Diary>();
        String sql = "SELECT id,username,create_time,content,mood FROM diary_info WHERE username=?";
        this.pstmt = this.conn.prepareStatement(sql);
        this.pstmt.setString(1, username);
        ResultSet rs = this.pstmt.executeQuery();
        while (rs.next()) {

            Diary diary = new Diary();

            diary.setId(rs.getInt(1));
            diary.setUsername(rs.getString(2));
            diary.setCreateTime(rs.getDate(3));
            diary.setContent(rs.getString(4));
            diary.setMood(rs.getString(5));

            diaries.add(diary);
        }

        this.pstmt.close();
        return diaries;
    }

    @Override
    public int delDiaryById(int id) throws Exception {

        int cnt = 0;
        String sql = "DELETE FROM diary_info WHERE id=?";
        this.pstmt = this.conn.prepareStatement(sql);
        this.pstmt.setInt(1, id);
        if ((cnt = this.pstmt.executeUpdate()) == 1) {
            System.out.println("delete from diary_info successfully.");
        }

        this.pstmt.close();
        return cnt;
    }

    @Override
    public int revDiaryById(int id, String content, String mood) throws Exception {

        int cnt = 0;
        String sql = "UPDATE diary_info SET content=?,mood=? WHERE id=?";
        this.pstmt = this.conn.prepareStatement(sql);
        this.pstmt.setString(1, content);
        this.pstmt.setString(2, mood);
        this.pstmt.setInt(3, id);
        if ((cnt = this.pstmt.executeUpdate()) == 1) {
            System.out.println("revise diary_info successfully.");
        }

        this.pstmt.close();
        return cnt;
    }
}
