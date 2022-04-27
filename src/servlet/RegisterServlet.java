package servlet;

import factory.DAOFactory;
import vo.Passwd;
import vo.Usr;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String successPath = "login.jsp";
        String failurePath = "register.jsp";

        Usr usr = new Usr();
        usr.setUsername(req.getParameter("username"));
        usr.setGender(Byte.parseByte(req.getParameter("gender")));
        usr.setAge(Integer.parseInt(req.getParameter("age")));
        usr.setEmail(req.getParameter("email"));

        Passwd passwd = new Passwd();
        passwd.setUsername(req.getParameter("username"));
        passwd.setPassword(req.getParameter("password"));

        Boolean flag = false;

        try {
            flag = DAOFactory.getIUsrDAOInstance().doCreateUsr(usr)
                    && DAOFactory.getIUsrDAOInstance().doCreatePasswd(passwd);
        } catch (Exception e) {
            e.printStackTrace();
        }

        try{
            if (flag) {
                req.getRequestDispatcher(successPath).forward(req, resp);
            } else {
                req.getRequestDispatcher(failurePath).forward(req, resp);
            }
        } catch(Exception e) {
            e.printStackTrace() ;
        }
    }
}
