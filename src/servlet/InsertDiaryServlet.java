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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class InsertDiaryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 设置 req 编码方式，防止乱码
        req.setCharacterEncoding("utf-8");

        // 从 session 中获取当前登录的用户
        HttpSession session = req.getSession();
        Passwd passwd = (Passwd) session.getAttribute("passwd");

        // 新建时间格式化类对象
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        // 从前端获得卡片数据
        Diary diary = new Diary();
        diary.setUsername(passwd.getUsername());
        try {
            diary.setCreateTime(sdf.parse(req.getParameter("diaryYear") + "-"
                    + req.getParameter("diaryMonth") + "-" + req.getParameter("diaryDay")));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        diary.setContent(req.getParameter("diaryContent"));
        diary.setMood(req.getParameter("moodContent"));

        // 将数据写入数据库
        try {
            DAOFactory.getIUsrDAOInstance().doCreateDiary(diary);
            resp.sendRedirect("ShowDiaryServlet");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
