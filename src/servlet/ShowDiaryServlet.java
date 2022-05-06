package servlet;

import factory.DAOFactory;
import vo.Passwd;
import vo.Diary;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class ShowDiaryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 从 session 中获取当前登录的用户
        HttpSession session = req.getSession();
        Passwd passwd = (Passwd) session.getAttribute("passwd");

        // 保存当前登录用户 record 记录的列表
        List<Diary> diaries = null;

        try {
            diaries = DAOFactory.getIUsrDAOInstance().findDiaryByUsername(passwd.getUsername());
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("diaryList", diaries);
        req.getRequestDispatcher("diary.jsp").forward(req, resp);
    }
}
