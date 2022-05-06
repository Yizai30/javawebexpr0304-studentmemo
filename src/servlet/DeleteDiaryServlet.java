package servlet;

import factory.DAOFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteDiaryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String successPath = "ShowDiaryServlet";
        String failurePath = "error.jsp";

        // 获取待删除的记录的 id
        String strId = req.getParameter("id");
        int id = 0;
        if (strId != null) {
            id = Integer.parseInt(strId);
        }

        // 删除相应的 record
        int cnt = 0;
        try {
            cnt = DAOFactory.getIUsrDAOInstance().delDiaryById(id);
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
