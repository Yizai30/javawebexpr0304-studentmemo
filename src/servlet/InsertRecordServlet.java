package servlet;

import factory.DAOFactory;
import vo.Passwd;
import vo.Record;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class InsertRecordServlet extends HttpServlet {
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
        Record record = new Record();
        record.setUsername(passwd.getUsername());
        record.setCreateTime(new Date());
        try {
            record.setDeadLine(sdf.parse(req.getParameter("ddlYear") + "-"
                    + req.getParameter("ddlMonth") + "-" + req.getParameter("ddlDay")));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        record.setContent(req.getParameter("eventContent"));
        record.setComplete(false);

        // 将数据写入数据库
        try {
            DAOFactory.getIUsrDAOInstance().doCreateRecord(record);
            resp.sendRedirect("ShowRecordServlet");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
