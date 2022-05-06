package dao;

import vo.Diary;
import vo.Passwd;
import vo.Record;
import vo.Usr;

import java.util.List;

public interface IUsrDAO {
    public boolean doCreateUsr(Usr usr) throws Exception; // 向 usr_info 表中插入用户的基本信息
    public boolean doCreatePasswd(Passwd passwd) throws Exception; // 向 usr_passwd 表中插入用户名和密码
    public Usr findByUsername(String username) throws Exception; // 根据 username 查询 usr_info 表中的所有 Usr
    public Passwd findByUsername2(String username) throws Exception; // 根据 username 查询，返回所有 Passwd
    public boolean check(Passwd passwd) throws Exception; // 登录校验

    public boolean doCreateRecord(Record record) throws Exception; // 向 record_info 表中插入记录
    public List<Record> findRecordByUsername(String username) throws Exception; // 根据 username 查询 record_info 表中的所有记录
    public int delRecordById(int id) throws Exception; // 根据 id 删除 record

    public boolean doCreateDiary(Diary diary) throws Exception; // 向 diary_info 表中插入记录
    public List<Diary> findDiaryByUsername(String username) throws Exception; // 根据 username 查询 diary_info 表中的所有记录
    public int delDiaryById(int id) throws Exception; // 根据 id 删除 diary
}
