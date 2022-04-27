package servlet;

import factory.DAOFactory;
import vo.Passwd;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String successPath = "IndexServlet";
        String failurePath = "login.jsp";
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Passwd passwd = new Passwd();
        passwd.setUsername(username);
        passwd.setPassword(password);

        Boolean flag=false;

        req.setCharacterEncoding("gbk");
        resp.setContentType("text/html;charset=gbk");

        try {
            flag = DAOFactory.getIUsrDAOInstance().check(passwd);
        } catch (Exception e) {
            e.printStackTrace();
        }

        try{
            if(flag){
                req.getSession().setAttribute("passwd", passwd);
                req.getRequestDispatcher(successPath).forward(req, resp);
            } else {
                req.getRequestDispatcher(failurePath).forward(req, resp);
            }
        }catch(Exception e){
            e.printStackTrace() ;
        }
    }
}
