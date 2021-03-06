package dao.proxy;

import dao.IUsrDAO;
import dao.impl.UsrDAOImpl;
import dbc.DatabaseConnection;
import vo.Diary;
import vo.Event;
import vo.Passwd;
import vo.Usr;

import java.util.Date;
import java.util.List;

public class UsrDAOProxy implements IUsrDAO {
    private DatabaseConnection dbc = null;
    private IUsrDAO dao = null;

    public UsrDAOProxy() throws Exception {
        this.dbc = new DatabaseConnection();
        this.dao = new UsrDAOImpl(this.dbc.getConn());
    }

    @Override
    public boolean doCreateUsr(Usr usr) throws Exception {
        boolean flag = false;
        try {
            if (this.dao.findByUsername(usr.getUsername()) == null) {
                flag = this.dao.doCreateUsr(usr);
            }
        } catch(Exception e) {
            throw e;
        } finally {
            this.dbc.close();
        }
        return flag;
    }

    @Override
    public boolean doCreatePasswd(Passwd passwd) throws Exception {
        boolean flag = false;
        try {
            if (this.dao.findByUsername2(passwd.getUsername()) == null) {
                flag = this.dao.doCreatePasswd(passwd);
            }
        } catch(Exception e) {
            throw e;
        } finally {
            this.dbc.close();
        }
        return flag;
    }

    @Override
    public Usr findByUsername(String username) throws Exception {
        Usr usr = null;
        try {
            usr = this.dao.findByUsername(username);
        } catch(Exception e) {
            throw e;
        } finally {
            this.dbc.close();
        }
        return usr;
    }

    @Override
    public Passwd findByUsername2(String username) throws Exception {
        Passwd passwd = null;
        try {
            passwd = this.dao.findByUsername2(username);
        } catch(Exception e) {
            throw e;
        } finally {
            this.dbc.close();
        }
        return passwd;
    }

    @Override
    public boolean check(Passwd passwd) throws Exception {
        boolean flag = false;
        try {
            flag = this.dao.check(passwd);
        } catch(Exception e) {
            throw e;
        } finally {
            this.dbc.close();
        }
        return flag;
    }

    @Override
    public boolean doCreateEvent(Event event) throws Exception {
        boolean flag = false;
        try {
            flag = this.dao.doCreateEvent(event);
        } catch(Exception e) {
            throw e;
        } finally {
            this.dbc.close();
        }
        return flag;
    }

    @Override
    public List<Event> findEventByUsername(String username) throws Exception {
        List<Event> events = null;
        try {
            events = this.dao.findEventByUsername(username);
        } catch (Exception e) {
            throw e;
        } finally {
            this.dbc.close();
        }
        return events;
    }

    @Override
    public int delEventById(int id) throws Exception {
        int cnt = 0;
        try {
            cnt = this.dao.delEventById(id);
        } catch (Exception e) {
            throw e;
        } finally {
            this.dbc.close();
        }
        return cnt;
    }

    @Override
    public int edtEventById(int id, Date deadLine, String content) throws Exception {
        int cnt = 0;
        try {
            cnt = this.dao.edtEventById(id, deadLine, content);
        } catch (Exception e) {
            throw e;
        } finally {
            this.dbc.close();
        }
        return cnt;
    }

    @Override
    public boolean doCreateDiary(Diary diary) throws Exception {
        boolean flag = false;
        try {
            flag = this.dao.doCreateDiary(diary);
        } catch (Exception e) {
            throw e;
        } finally {
            this.dbc.close();
        }
        return flag;
    }

    @Override
    public List<Diary> findDiaryByUsername(String username) throws Exception {
        List<Diary> diaries = null;
        try {
            diaries = this.dao.findDiaryByUsername(username);
        } catch (Exception e) {
            throw e;
        } finally {
            this.dbc.close();
        }
        return diaries;
    }

    @Override
    public int delDiaryById(int id) throws Exception {
        int cnt = 0;
        try {
            cnt = this.dao.delDiaryById(id);
        } catch (Exception e) {
            throw e;
        } finally {
            this.dbc.close();
        }
        return cnt;
    }

    @Override
    public int revDiaryById(int id, String content, String mood) throws Exception {
        int cnt = 0;
        try {
            cnt = this.dao.revDiaryById(id, content, mood);
        } catch (Exception e) {
            throw e;
        } finally {
            this.dbc.close();
        }
        return cnt;
    }
}
