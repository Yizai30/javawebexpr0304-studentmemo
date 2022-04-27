package factory;

import dao.IUsrDAO;
import dao.proxy.UsrDAOProxy;

public class DAOFactory {
    public static IUsrDAO getIUsrDAOInstance() throws Exception {
        return new UsrDAOProxy();
    }
}
