package dao.impl;

import dao.IUsrDAO;
import vo.Passwd;
import vo.Usr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
}
