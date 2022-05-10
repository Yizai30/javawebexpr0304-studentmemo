<%--
  Created by IntelliJ IDEA.
  User: Mena
  Date: 2022/5/10
  Time: 20:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login To STM</title>
    <link rel="stylesheet" href="css/style01.css">
</head>
<body>
<div class="container">
    <div class="tit">Admin登录</div>
    <form class="subcontainer" name="loginForm" action="CheckAdminServlet" method="post">
        <input class="inputext" type="text" placeholder="用户名" name="username"/>
        <input class="inputext" type="password" placeholder="密码" name="password"/>
        <input class="smbutton" type="button" value="登录" onclick="checkLogin(this.form)"/>
    </form>
    <span>没有账号？<a href="register.jsp">去注册</a></span>
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

<script type="text/javascript">
    function checkLogin(form) {
        if (!isUsername(form.username.value)) {
            alert("用户名请填写 4-16 位的英文字符,数字,下划线");
            form.username.focus();
            return false;
        }
        if (!isPassword(form.password.value)) {
            alert("密码请填写 6-16 位的英文字符,数字,下划线");
            form.password.focus();
            return false;
        }
        document.loginForm.submit();
    }
    function isUsername(str) {
        var reg = /^[a-zA-Z0-9_]{4,16}$/;   /*定义验证表达式*/
        return reg.test(str);     /*进行验证*/
    }
    function isPassword(str) {
        var reg = /^[a-zA-Z\d_]{6,16}$/;
        return reg.test(str);
    }
</script>
</body>
</html>
