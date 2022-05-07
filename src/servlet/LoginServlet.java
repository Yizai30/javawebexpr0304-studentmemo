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

        // 设置 response 编码方式，防止乱码
        resp.setContentType("text/html;charset=utf-8");

        String successPath = "ShowEventServlet";
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
                resp.getWriter().print("<script>alert('登录成功！');" +
                        "window.location.href='" + successPath + "';</script>");
            } else {
                resp.getWriter().print("<script>alert('登录失败，请检查用户名和密码是否正确');" +
                        "window.location.href='" + failurePath + "';</script>");
            }
        }catch(Exception e){
            e.printStackTrace() ;
        }
    }
}
