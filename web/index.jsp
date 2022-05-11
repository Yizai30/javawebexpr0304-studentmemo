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
    <link rel="stylesheet" href="./css/style04.css">
</head>
<body>
    <h1 style="font-size: 50px;">Welcome To STM</h1>
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

    <script src="./js/vanilla-tilt.js"></script>
    <script>

        VanillaTilt.init(document.querySelectorAll(".card"),{
            max: 3,    // 最大倾斜度数
            speed: 330, // 倾斜转换的速度
            glare: true,    // 是否开启眩光效果
            "max-glare": 1  // 最大眩光的不透明度
        })

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
