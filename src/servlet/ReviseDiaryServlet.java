package servlet;

import factory.DAOFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ReviseDiaryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 设置编码方式，防止乱码
        resp.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("utf-8");

        String successPath = "ShowDiaryServlet";
        String failurePath = "error.jsp";

        // 获取待修改的日记的 id, content, mood
        int id = 0;
        String rStrId = req.getParameter("rId");
        if (rStrId != null) {
            id = Integer.parseInt(rStrId);
        }
        String content = req.getParameter("rDiaryContent");
        String mood = req.getParameter("rMoodContent");

        // 修改相应的 diary
        int cnt = 0;
        try {
            cnt = DAOFactory.getIUsrDAOInstance().revDiaryById(id, content, mood);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (cnt == 1) {
            req.getRequestDispatcher(successPath).forward(req, resp);
        } else {
            req.getRequestDispatcher(failurePath).forward(req, resp);
        }
    }
}
