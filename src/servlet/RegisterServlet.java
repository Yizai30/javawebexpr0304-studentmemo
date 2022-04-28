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

        // 设置 response 编码方式，防止乱码
        resp.setContentType("text/html;charset=utf-8");

        String successPath = "login.jsp";
        String failurePath = "register.jsp";

        Usr usr = new Usr();
        usr.setUsername(req.getParameter("username"));
        usr.setGender(Byte.parseByte(req.getParameter("gender")));
        if (req.getParameter("age") != null
                && !req.getParameter("age").equals("")) {
            usr.setAge(Integer.parseInt(req.getParameter("age")));
        }
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
                resp.getWriter().print("<script>alert('注册成功！');" +
                        "window.location.href='" + successPath + "';</script>");
            } else {
                resp.getWriter().print("<script>alert('用户已存在，请直接登录');" +
                        "window.location.href='" + successPath + "';</script>");
            }
        } catch(Exception e) {
            e.printStackTrace() ;
        }
    }
}
