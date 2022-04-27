package dao.proxy;

import dao.IUsrDAO;
import dao.impl.UsrDAOImpl;
import dbc.DatabaseConnection;
import vo.Passwd;
import vo.Usr;

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
}
