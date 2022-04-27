<%--
  Created by IntelliJ IDEA.
  User: Mena
  Date: 2022/4/21
  Time: 14:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome To STM</title>
</head>
<body>
    <%
        if (request.getSession().getAttribute("passwd") == null) {
            response.sendRedirect("IndexServlet");
        }
    %>
</body>
</html>
