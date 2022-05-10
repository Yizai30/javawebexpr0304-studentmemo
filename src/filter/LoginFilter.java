package filter;

import vo.Passwd;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {

    // 服务器启动时，就已初始化，随时等待过滤的对象
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("LoginFilter初始化...");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        // 请求和响应的类型转换
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        // 设置 response 编码方式，防止乱码
        resp.setContentType("text/html;charset=utf-8");

        String failurePath = "login.jsp";

        // 获取 session 中保存的用户信息
        HttpSession session = req.getSession();
        Passwd passwd = (Passwd) session.getAttribute("passwd");

        // 判断是否登录
        if (passwd == null) {  // 考虑使用多线程实现动态倒计时
            resp.getWriter().print("您还未登录，3秒后将跳转到<a href='login.jsp'>登录页面</a>");
            resp.setHeader("Refresh","3;URL="+failurePath);
        } else {
            chain.doFilter(req, resp);
        }
    }

    // 服务器关闭时，过滤器销毁
    @Override
    public void destroy() {
        System.out.println("LoginFilter销毁...");
    }
}
