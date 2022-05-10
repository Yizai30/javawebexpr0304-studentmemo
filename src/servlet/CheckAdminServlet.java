package servlet;

import factory.DAOFactory;
import vo.Passwd;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CheckAdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 设置 response 编码方式，防止乱码
        resp.setContentType("text/html;charset=utf-8");

        String successPath = "LoginServlet";
        String failurePath = "admin_login.jsp";
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Passwd passwd = new Passwd();
        passwd.setUsername(username);
        passwd.setPassword(password);

        req.setCharacterEncoding("gbk");
        resp.setContentType("text/html;charset=gbk");

        if(username.equals("admin")) {
            req.getRequestDispatcher(successPath).forward(req, resp);
        } else {
            resp.getWriter().print("<script>alert('登录失败，您不是管理员');" +
                    "window.location.href='" + failurePath + "';</script>");
        }
    }
}
