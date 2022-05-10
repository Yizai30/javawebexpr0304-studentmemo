<%--
  Created by IntelliJ IDEA.
  User: Mena
  Date: 2022/5/10
  Time: 20:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome To STM</title>
    <link rel="stylesheet" href="./css/style04.css">
</head>
<body>
<%
    if (request.getSession().getAttribute("passwd") == null) {
        response.sendRedirect("check_admin");
    }
%>
<h1 style="font-size: 50px;">Admin</h1>
<div id="currentTime" style="margin-top: 5px;font-size: 20px"></div>
<img src="./images/showlink.png" width="80" height="80">
<div class="container">
    <a class="card" href="ShowEventServlet">
        查看我的事件
    </a>
    <a class="card" href="ShowDiaryServlet">
        查看我的日记
    </a>
</div>

<script>
    window.onload = function() {
        var date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth() + 1;    // 不知道为什么日期晚了一个月...
        var day = date.getDate();
        var weekDay = date.getDay();
        var week = ["日", "一", "二", "三", "四", "五", "六"];
        if (month < 10) month = "0" + month;
        if (day < 10) day = "0" + day;
        document.getElementById('currentTime').innerHTML =
            year + "年" + month + "月" + day + "日" + " 星期" + week[weekDay];
    }
</script>
</body>
</html>
