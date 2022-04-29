package servlet;

import vo.Passwd;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class JudgeLoginRecordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 设置 response 编码方式，防止乱码
        resp.setContentType("text/html;charset=utf-8");

        String successPath = "ShowRecordServlet";
        String failurePath = "login.jsp";

        // 创建 session 保存用户信息
        HttpSession session = req.getSession();

        // 获得 session 中的用户对象
        Passwd passwd = (Passwd) session.getAttribute("passwd");

        // 判断是否登录
        if (passwd == null) {  // 考虑使用多线程实现动态倒计时
            resp.getWriter().print("您还未登录，3秒后将跳转到<a href='login.jsp'>登录页面</a>");
            resp.setHeader("Refresh","3;URL="+failurePath);
        } else {
            Cookie cookie = new Cookie("JSESSIONID", session.getId());
            resp.addCookie(cookie);
            req.getRequestDispatcher(successPath).forward(req, resp);
        }
    }
}
