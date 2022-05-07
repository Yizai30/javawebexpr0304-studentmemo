package servlet;

import factory.DAOFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class EditRecordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 设置编码方式，防止乱码
        resp.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("utf-8");

        String successPath = "ShowRecordServlet";
        String failurePath = "error.jsp";

        // 新建时间格式化类对象
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        // 获取待修改的记录的 id, deadLine, content
        int id = 0;
        String eStrId = req.getParameter("eId");
        if (eStrId != null) {
            id = Integer.parseInt(eStrId);
        }
        Date deadLine = null;
        try {
            deadLine = sdf.parse(req.getParameter("eDdlYear") + "-"
                                        + req.getParameter("eDdlMonth") + "-"
                                        + req.getParameter("eDdlDay"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String content = req.getParameter("eEventContent");

        // 修改相应的 record
        int cnt = 0;
        try {
            cnt = DAOFactory.getIUsrDAOInstance().edtRecordById(id, deadLine, content);
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
