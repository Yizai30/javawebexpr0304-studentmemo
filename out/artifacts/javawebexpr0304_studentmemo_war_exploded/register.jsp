<%--
  Created by IntelliJ IDEA.
  User: Mena
  Date: 2022/4/21
  Time: 14:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register For STM</title>
    <link rel="stylesheet" href="css/style01.css">
</head>
<body>
    <div class="container" style="height: 680px;">
        <div class="tit">注册</div>
        <form class="subcontainer" action="RegisterServlet" method="post">
            <input class="inputext" type="text" placeholder="用户名" name="username">
            <span class="gb">
                <input class="gbmale" id="male" type="radio" name="gender" value="1">
                <label for="male">男</label>
                <input class="gbfemale" id="female" type="radio" name="gender" value="2">
                <label for="female">女</label>
            </span>
            <input class="inputext" type="text" placeholder="年龄" name="age">
            <input class="inputext" type="text" placeholder="邮箱" name="email">
            <input class="inputext" type="password" placeholder="密码" name="password">
            <input class="inputext" type="password" placeholder="确认密码" name="confirmPassword">
            <button type="submit">注册</button>
        </form>
        <span>已有账号？<a href="login.jsp">去登录</a></span>
    </div>
    <div class="square">
        <ul>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
    <div class="circle">
        <ul>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</body>
</html>
