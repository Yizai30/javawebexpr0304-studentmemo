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
        <form class="subcontainer" name="registerForm" action="RegisterServlet" method="post">
            <input class="inputext" type="text" placeholder="用户名" name="username"/>
            <span class="gb">
                <input class="gbneutral" id="neutral" type="radio" name="gender" value="0" checked>
                <label for="neutral">保密</label>
                <input class="gbmale" id="male" type="radio" name="gender" value="1">
                <label for="male">男</label>
                <input class="gbfemale" id="female" type="radio" name="gender" value="2">
                <label for="female">女</label>
            </span>
            <input class="inputext" type="text" placeholder="年龄" name="age"/>
            <input class="inputext" type="text" placeholder="邮箱" name="email"/>
            <input class="inputext" type="password" placeholder="密码" name="password"/>
            <input class="inputext" type="password" placeholder="确认密码" name="confirmPassword"/>
            <input class="smbutton" type="button" value="注册" onclick="checkRegister(this.form)"/>
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

    <script type="text/javascript">
        function checkRegister(form) {
            if (!isUsername(form.username.value)) {
                alert("用户名请填写 4-16 位的英文字符,数字,下划线");
                form.username.focus();
                return false;
            }
            if (!isAge(form.age.value)) {
                alert("年龄请填写 0-150 之间的数值");
                form.age.focus();
                return false;
            }
            if (!isEmail(form.email.value)) {
                alert("请使用 qq 163 126 gmail cumt.edu.cn 等邮箱注册，请输入正确的邮箱格式");
                form.email.focus();
                return false;
            }
            if (!isPassword(form.password.value)) {
                alert("密码请填写 6-16 位的英文字符,数字,下划线");
                form.password.focus();
                return false;
            }
            if (form.password.value !== form.confirmPassword.value) {
                alert("请使两次输入的密码保持一致");
                form.confirmPassword.focus();
                return false;
            }
            document.registerForm.submit();
        }
        function isUsername(str) {
            var reg = /^[a-zA-Z0-9_]{4,16}$/;   /*定义验证表达式*/
            return reg.test(str);     /*进行验证*/
        }
        function isAge(str) {
            var reg = /^([0-9]|[1-9][0-9]|1[0-4][0-9]|150)$/;
            return reg.test(str);
        }
        function isEmail(str) {
            var reg = /^([0-9a-zA-Z_]{6,12}@((qq|163|126|gmail).com|cumt.edu.cn))$/;
            return reg.test(str);
        }
        function isPassword(str) {
            var reg = /^[a-zA-Z\d_]{6,16}$/;
            return reg.test(str);
        }
    </script>
</body>
</html>
