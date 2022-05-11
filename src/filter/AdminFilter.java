package filter;

import vo.Passwd;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AdminFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AdminFilter初始化...");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        // 请求和响应的类型转换
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        // 设置 response 编码方式，防止乱码
        resp.setContentType("text/html;charset=utf-8");

        String noLoginPath = "login.jsp";
        String loginOrdinaryPath = "index.jsp";
        String loginAdminPath = "admin.jsp";

        // 获取 session 中保存的用户信息
        HttpSession session = req.getSession();
        Passwd passwd = (Passwd) session.getAttribute("passwd");

        // 若未登录，跳转到登录界面，否则判断是否为 admin
        if (passwd == null) {  // 考虑使用多线程实现动态倒计时
            resp.getWriter().print("您还未登录，3秒后将跳转到<a href='login.jsp'>登录页面</a>");
            resp.setHeader("Refresh","3;URL="+noLoginPath);
        } else {
            if (passwd.getUsername().equals("admin")) {
                req.getRequestDispatcher(loginAdminPath).forward(req, resp);
            }
            else {
                req.getRequestDispatcher(loginOrdinaryPath).forward(req, resp);
            }
            chain.doFilter(req, resp);
        }
    }

    @Override
    public void destroy() {
        System.out.println("AdminFilter销毁...");
    }
}
